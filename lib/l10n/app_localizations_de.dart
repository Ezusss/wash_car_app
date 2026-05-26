// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Wann Auto Waschen';

  @override
  String get safeToWash => 'Sicher zum Waschen';

  @override
  String get notRecommended => 'Nicht Empfohlen';

  @override
  String get notSafe => 'Nicht Sicher';

  @override
  String get weatherConditionsAreGood =>
      'Die Wetterbedingungen sind gut zum Autowaschen.';

  @override
  String get weatherConditionsAreNotIdeal =>
      'Die Wetterbedingungen sind nicht ideal. Erwägen Sie zu warten.';

  @override
  String get poorWeatherConditions =>
      'Schlechte Wetterbedingungen. Warten Sie auf bessere Bedingungen.';

  @override
  String bestTimeText(Object date) {
    return 'Beste Zeit: $date';
  }

  @override
  String score(Object score) {
    return 'Bewertung: $score/100';
  }

  @override
  String get settings => 'Einstellungen';

  @override
  String get location => 'Standort';

  @override
  String get autoLocation => 'Automatischer Standort';

  @override
  String get useDeviceLocation => 'Gerätestandort verwenden';

  @override
  String get enterCityName => 'Geben Sie den Stadtnamen ein';

  @override
  String get display => 'Anzeige';

  @override
  String get temperatureUnit => 'Temperatureinheit';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get about => 'Über';

  @override
  String get appVersion => 'App-Version';

  @override
  String get weatherData => 'Wetterdaten';

  @override
  String get poweredByWeatherAPI => 'Unterstützt durch WeatherAPI.com';

  @override
  String get currentWeather => 'Aktuelles Wetter';

  @override
  String get temperature => 'Temperatur';

  @override
  String get humidity => 'Luftfeuchtigkeit';

  @override
  String get windSpeed => 'Windgeschwindigkeit';

  @override
  String get rainChance => 'Regenwahrscheinlichkeit';

  @override
  String get uvIndex => 'UV-Index';

  @override
  String get condition => 'Zustand';

  @override
  String get tenDayForecast => '10-Tage-Vorhersage';

  @override
  String get today => 'Heute';

  @override
  String errorLoadingWeather(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get unableToLoadWeather => 'Wetterdaten können nicht geladen werden';

  @override
  String get retry => 'Erneut Versuchen';

  @override
  String get city => 'Stadt';

  @override
  String get safe => 'Sicher';

  @override
  String get warning => 'Warnung';

  @override
  String get unsafe => 'Unsicher';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get notificationsSubtitle =>
      'Benachrichtigungen über gute Waschtage erhalten';

  @override
  String get scoreBreakdown => 'Bewertungsaufschlüsselung';

  @override
  String get selectedDayBreakdown => 'Aufschlüsselung des gewählten Tages';

  @override
  String get noRain => 'Kein Regen';

  @override
  String get noRainCurrently => 'Derzeit kein Regen';

  @override
  String get noSnow => 'Kein Schnee';

  @override
  String get noSnowCurrently => 'Derzeit kein Schnee';

  @override
  String get rainExpected => 'Regen erwartet';

  @override
  String get snowExpected => 'Schnee erwartet';

  @override
  String get clearWeather => 'Klar';

  @override
  String get loadingText => 'Laden';

  @override
  String get goodLabel => 'Gut';

  @override
  String get badLabel => 'Schlecht';

  @override
  String get offlineMessage =>
      'Vorhersage konnte nicht aktualisiert werden. Letzte Daten werden angezeigt.';
}
