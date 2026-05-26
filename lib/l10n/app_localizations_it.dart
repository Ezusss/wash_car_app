// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Quando Lavare';

  @override
  String get safeToWash => 'Sicuro da Lavare';

  @override
  String get notRecommended => 'Non Consigliato';

  @override
  String get notSafe => 'Non Sicuro';

  @override
  String get weatherConditionsAreGood =>
      'Le condizioni meteorologiche sono buone per lavare l\'auto.';

  @override
  String get weatherConditionsAreNotIdeal =>
      'Le condizioni meteorologiche non sono ideali. Considera di aspettare.';

  @override
  String get poorWeatherConditions =>
      'Cattive condizioni meteorologiche. Aspetta condizioni migliori.';

  @override
  String bestTimeText(Object date) {
    return 'Momento migliore: $date';
  }

  @override
  String score(Object score) {
    return 'Punteggio: $score/100';
  }

  @override
  String get settings => 'Impostazioni';

  @override
  String get location => 'Posizione';

  @override
  String get autoLocation => 'Posizione Automatica';

  @override
  String get useDeviceLocation => 'Utilizza la posizione del dispositivo';

  @override
  String get enterCityName => 'Immetti il nome della città';

  @override
  String get display => 'Display';

  @override
  String get temperatureUnit => 'Unità di Temperatura';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get about => 'Informazioni';

  @override
  String get appVersion => 'Versione App';

  @override
  String get weatherData => 'Dati Meteo';

  @override
  String get poweredByWeatherAPI => 'Fornito da WeatherAPI.com';

  @override
  String get currentWeather => 'Meteo Attuale';

  @override
  String get temperature => 'Temperatura';

  @override
  String get humidity => 'Umidità';

  @override
  String get windSpeed => 'Velocità del Vento';

  @override
  String get rainChance => 'Probabilità di Pioggia';

  @override
  String get uvIndex => 'Indice UV';

  @override
  String get condition => 'Condizione';

  @override
  String get tenDayForecast => 'Previsione a 10 Giorni';

  @override
  String get today => 'Oggi';

  @override
  String errorLoadingWeather(Object error) {
    return 'Errore: $error';
  }

  @override
  String get unableToLoadWeather => 'Impossibile caricare i dati meteo';

  @override
  String get retry => 'Riprova';

  @override
  String get city => 'Città';

  @override
  String get safe => 'Sicuro';

  @override
  String get warning => 'Avvertenza';

  @override
  String get unsafe => 'Non Sicuro';

  @override
  String get notifications => 'Notifiche';

  @override
  String get notificationsSubtitle =>
      'Ricevi avvisi per i giorni ideali al lavaggio';

  @override
  String get scoreBreakdown => 'Dettaglio punteggio';

  @override
  String get selectedDayBreakdown => 'Dettaglio giorno selezionato';

  @override
  String get noRain => 'Nessuna pioggia';

  @override
  String get noRainCurrently => 'Nessuna pioggia al momento';

  @override
  String get noSnow => 'Nessuna neve';

  @override
  String get noSnowCurrently => 'Nessuna neve al momento';

  @override
  String get rainExpected => 'Pioggia prevista';

  @override
  String get snowExpected => 'Neve prevista';

  @override
  String get clearWeather => 'Sereno';

  @override
  String get loadingText => 'Caricamento';

  @override
  String get goodLabel => 'Buono';

  @override
  String get badLabel => 'Cattivo';

  @override
  String get offlineMessage =>
      'Impossibile aggiornare le previsioni. Visualizzazione degli ultimi dati.';
}
