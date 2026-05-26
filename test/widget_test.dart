import 'package:flutter_test/flutter_test.dart';
import 'package:wash_car_app/data/models/weather_model.dart';
import 'package:wash_car_app/domain/usecases/wash_recommendation_usecase.dart';

void main() {
  group('WashRecommendationUseCase', () {
    late WashRecommendationUseCase useCase;

    setUp(() {
      useCase = WashRecommendationUseCase();
    });

    test('Safe conditions should return high score', () {
      // Create a safe weather forecast
      final current = WeatherData(
        tempC: 20,
        tempF: 68,
        humidity: 50,
        windSpeedMs: 5,
        rainChance: 10,
        condition: 'Sunny',
        isRaining: false,
        isSnowing: false,
        uvIndex: 5,
        dateTime: DateTime.now(),
      );

      final forecastDay = ForecastDay(
        date: DateTime.now(),
        maxTempC: 22,
        minTempC: 18,
        avgHumidity: 55,
        maxWindSpeed: 6,
        rainChance: 5,
        rainMm: 0,
        condition: 'Sunny',
        hasRain: false,
        hasSnow: false,
        hourly: [],
      );

      final forecast = WeatherForecast(
        current: current,
        forecast: [forecastDay],
        location: 'Test City',
        latitude: 40.0,
        longitude: -74.0,
        lastUpdated: DateTime.now(),
      );

      final recommendation = useCase.getRecommendation(forecast);
      expect(recommendation.status, 'safe');
      expect(recommendation.score, greaterThanOrEqualTo(70));
    });

    test('Rainy conditions should return low score', () {
      final current = WeatherData(
        tempC: 15,
        tempF: 59,
        humidity: 85,
        windSpeedMs: 8,
        rainChance: 90,
        condition: 'Rainy',
        isRaining: true,
        isSnowing: false,
        uvIndex: 1,
        dateTime: DateTime.now(),
      );

      final forecastDay = ForecastDay(
        date: DateTime.now(),
        maxTempC: 16,
        minTempC: 14,
        avgHumidity: 90,
        maxWindSpeed: 10,
        rainChance: 95,
        rainMm: 10,
        condition: 'Rainy',
        hasRain: true,
        hasSnow: false,
        hourly: [],
      );

      final forecast = WeatherForecast(
        current: current,
        forecast: [forecastDay],
        location: 'Test City',
        latitude: 40.0,
        longitude: -74.0,
        lastUpdated: DateTime.now(),
      );

      final recommendation = useCase.getRecommendation(forecast);
      expect(recommendation.status, 'unsafe');
      expect(recommendation.score, lessThan(40));
    });

    test('Strong wind should reduce score', () {
      final current = WeatherData(
        tempC: 20,
        tempF: 68,
        humidity: 60,
        windSpeedMs: 15, // Above threshold
        rainChance: 10,
        condition: 'Cloudy',
        isRaining: false,
        isSnowing: false,
        uvIndex: 3,
        dateTime: DateTime.now(),
      );

      final forecastDay = ForecastDay(
        date: DateTime.now(),
        maxTempC: 21,
        minTempC: 19,
        avgHumidity: 65,
        maxWindSpeed: 16,
        rainChance: 15,
        rainMm: 0,
        condition: 'Cloudy',
        hasRain: false,
        hasSnow: false,
        hourly: [],
      );

      final forecast = WeatherForecast(
        current: current,
        forecast: [forecastDay],
        location: 'Test City',
        latitude: 40.0,
        longitude: -74.0,
        lastUpdated: DateTime.now(),
      );

      final recommendation = useCase.getRecommendation(forecast);
      expect(recommendation.score, lessThan(70));
    });

    test('Snow conditions should make it unsafe', () {
      final current = WeatherData(
        tempC: -5,
        tempF: 23,
        humidity: 80,
        windSpeedMs: 8,
        rainChance: 100,
        condition: 'Snowy',
        isRaining: false,
        isSnowing: true,
        uvIndex: 0,
        dateTime: DateTime.now(),
      );

      final forecastDay = ForecastDay(
        date: DateTime.now(),
        maxTempC: -4,
        minTempC: -6,
        avgHumidity: 85,
        maxWindSpeed: 9,
        rainChance: 100,
        rainMm: 5,
        condition: 'Snowy',
        hasRain: false,
        hasSnow: true,
        hourly: [],
      );

      final forecast = WeatherForecast(
        current: current,
        forecast: [forecastDay],
        location: 'Test City',
        latitude: 40.0,
        longitude: -74.0,
        lastUpdated: DateTime.now(),
      );

      final recommendation = useCase.getRecommendation(forecast);
      expect(recommendation.status, 'unsafe');
    });

    test('getScoresForForecast should return map with all days', () {
      final current = WeatherData(
        tempC: 20,
        tempF: 68,
        humidity: 50,
        windSpeedMs: 5,
        rainChance: 10,
        condition: 'Sunny',
        isRaining: false,
        isSnowing: false,
        uvIndex: 5,
        dateTime: DateTime.now(),
      );

      final days = List.generate(
        10,
        (index) => ForecastDay(
          date: DateTime.now().add(Duration(days: index)),
          maxTempC: 22,
          minTempC: 18,
          avgHumidity: 55,
          maxWindSpeed: 6,
          rainChance: 5 + (index * 5), // Increasing rain chance
          rainMm: 0,
          condition: 'Sunny',
          hasRain: false,
          hasSnow: false,
          hourly: [],
        ),
      );

      final forecast = WeatherForecast(
        current: current,
        forecast: days,
        location: 'Test City',
        latitude: 40.0,
        longitude: -74.0,
        lastUpdated: DateTime.now(),
      );

      final scores = useCase.getScoresForForecast(forecast);
      expect(scores.length, 10);
      
      // Earlier days should have higher scores
      final scoresList = scores.values.toList();
      expect(scoresList[0], greaterThanOrEqualTo(scoresList[9]));
    });
  });
}

