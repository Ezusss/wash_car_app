// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'When to Wash';

  @override
  String get safeToWash => 'Safe to Wash';

  @override
  String get notRecommended => 'Not Recommended';

  @override
  String get notSafe => 'Not Safe';

  @override
  String get weatherConditionsAreGood =>
      'Weather conditions are good for car washing.';

  @override
  String get weatherConditionsAreNotIdeal =>
      'Weather conditions are not ideal. Consider waiting.';

  @override
  String get poorWeatherConditions =>
      'Poor weather conditions. Wait for better conditions.';

  @override
  String bestTimeText(Object date) {
    return 'Best time: $date';
  }

  @override
  String score(Object score) {
    return 'Score: $score/100';
  }

  @override
  String get settings => 'Settings';

  @override
  String get location => 'Location';

  @override
  String get autoLocation => 'Auto Location';

  @override
  String get useDeviceLocation => 'Use device location';

  @override
  String get enterCityName => 'Enter city name';

  @override
  String get display => 'Display';

  @override
  String get temperatureUnit => 'Temperature Unit';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get about => 'About';

  @override
  String get appVersion => 'App Version';

  @override
  String get weatherData => 'Weather Data';

  @override
  String get poweredByWeatherAPI => 'Powered by WeatherAPI.com';

  @override
  String get currentWeather => 'Current Weather';

  @override
  String get temperature => 'Temperature';

  @override
  String get humidity => 'Humidity';

  @override
  String get windSpeed => 'Wind Speed';

  @override
  String get rainChance => 'Rain Chance';

  @override
  String get uvIndex => 'UV Index';

  @override
  String get condition => 'Condition';

  @override
  String get tenDayForecast => '10-Day Forecast';

  @override
  String get today => 'Today';

  @override
  String errorLoadingWeather(Object error) {
    return 'Error: $error';
  }

  @override
  String get unableToLoadWeather => 'Unable to load weather data';

  @override
  String get retry => 'Retry';

  @override
  String get city => 'City';

  @override
  String get safe => 'Safe';

  @override
  String get warning => 'Warn';

  @override
  String get unsafe => 'Unsafe';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsSubtitle => 'Get notified about good wash days';

  @override
  String get scoreBreakdown => 'Score Breakdown';

  @override
  String get selectedDayBreakdown => 'Selected Day Breakdown';

  @override
  String get noRain => 'No Rain';

  @override
  String get noRainCurrently => 'No Rain Currently';

  @override
  String get noSnow => 'No Snow';

  @override
  String get noSnowCurrently => 'No Snow Currently';

  @override
  String get rainExpected => 'Rain expected';

  @override
  String get snowExpected => 'Snow expected';

  @override
  String get clearWeather => 'Clear';

  @override
  String get loadingText => 'Loading';

  @override
  String get goodLabel => 'Good';

  @override
  String get badLabel => 'Bad';

  @override
  String get offlineMessage =>
      'Unable to update forecast. Showing latest data.';
}
