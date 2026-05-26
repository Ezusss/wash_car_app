import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_car_app/data/api/location_service.dart';
import 'package:wash_car_app/data/api/weather_service.dart';
import 'package:wash_car_app/data/cache/weather_cache.dart';
import 'package:wash_car_app/data/models/weather_model.dart';
import 'package:wash_car_app/data/services/home_widget_service.dart';
import 'package:wash_car_app/domain/usecases/wash_recommendation_usecase.dart';

// Service providers
final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (ref) => SharedPreferences.getInstance(),
);

final locationServiceProvider = Provider(
  (ref) => LocationService(),
);

final weatherServiceProvider = Provider(
  (ref) => WeatherService(),
);

final weatherCacheProvider = FutureProvider<WeatherCache>(
  (ref) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return WeatherCache(prefs);
  },
);

final washRecommendationUseCaseProvider = Provider(
  (ref) => WashRecommendationUseCase(),
);

// State providers — initial values are overridden from SharedPreferences in main()
final selectedCityProvider = StateProvider<String?>((ref) => null);
final useAutoLocationProvider = StateProvider<bool>((ref) => true);
final temperatureUnitProvider = StateProvider<String>((ref) => 'C');
final notificationsEnabledProvider = StateProvider<bool>((ref) => false);
final selectedForecastDayProvider = StateProvider<ForecastDay?>((ref) => null);

// Location provider
final currentLocationProvider = FutureProvider<Position?>((ref) async {
  if (!ref.watch(useAutoLocationProvider)) {
    return null;
  }

  final locationService = ref.watch(locationServiceProvider);
  try {
    return await locationService.getCurrentLocation();
  } catch (e) {
    return await locationService.getLastKnownLocation();
  }
});

// Weather forecast provider — falls back to cache on network failure
final weatherForecastProvider = FutureProvider<WeatherForecast?>((ref) async {
  final weatherService = ref.watch(weatherServiceProvider);
  final cache = await ref.watch(weatherCacheProvider.future);
  final selectedCity = ref.watch(selectedCityProvider);
  final location = await ref.watch(currentLocationProvider.future);

  String? city = selectedCity;

  // Attempt live fetch — try selected city first, then coordinates
  try {
    WeatherForecast forecast;

    if (city != null && city.isNotEmpty) {
      forecast = await weatherService.getWeatherByCity(city);
    } else if (location != null) {
      forecast = await weatherService.getWeatherByCoordinates(
        location.latitude,
        location.longitude,
      );
    } else {
      // No location available; fall back to last cached city
      city = cache.getSelectedCity();
      if (city != null) {
        forecast = await weatherService.getWeatherByCity(city);
      } else {
        return cache.getCachedWeather();
      }
    }

    await cache.saveWeather(forecast);
    return forecast;
  } catch (_) {
    // Network or API error — serve cached data so the user sees latest data
    return cache.getCachedWeather();
  }
});

// Wash recommendation provider with home widget update
final washRecommendationProvider = FutureProvider<WashRecommendation?>((ref) async {
  final forecast = await ref.watch(weatherForecastProvider.future);
  final useCase = ref.watch(washRecommendationUseCaseProvider);

  if (forecast == null) return null;

  final recommendation = useCase.getRecommendation(forecast);
  await HomeWidgetService.updateWidget(recommendation, forecast);
  return recommendation;
});

// 10-day forecast scores
final forecastScoresProvider = FutureProvider<Map<DateTime, int>>((ref) async {
  final forecast = await ref.watch(weatherForecastProvider.future);
  final useCase = ref.watch(washRecommendationUseCaseProvider);

  if (forecast == null) return {};

  return useCase.getScoresForForecast(forecast);
});
