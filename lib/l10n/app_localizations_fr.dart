// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Quand Laver';

  @override
  String get safeToWash => 'Sûr de Laver';

  @override
  String get notRecommended => 'Non Recommandé';

  @override
  String get notSafe => 'Non Sûr';

  @override
  String get weatherConditionsAreGood =>
      'Les conditions météorologiques sont bonnes pour laver la voiture.';

  @override
  String get weatherConditionsAreNotIdeal =>
      'Les conditions météorologiques ne sont pas idéales. Envisagez d\'attendre.';

  @override
  String get poorWeatherConditions =>
      'Mauvaises conditions météorologiques. Attendez de meilleures conditions.';

  @override
  String bestTimeText(Object date) {
    return 'Meilleur moment : $date';
  }

  @override
  String score(Object score) {
    return 'Score : $score/100';
  }

  @override
  String get settings => 'Paramètres';

  @override
  String get location => 'Localisation';

  @override
  String get autoLocation => 'Localisation Automatique';

  @override
  String get useDeviceLocation => 'Utiliser la localisation de l\'appareil';

  @override
  String get enterCityName => 'Entrez le nom de la ville';

  @override
  String get display => 'Affichage';

  @override
  String get temperatureUnit => 'Unité de Température';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get about => 'À Propos';

  @override
  String get appVersion => 'Version de l\'Application';

  @override
  String get weatherData => 'Données Météorologiques';

  @override
  String get poweredByWeatherAPI => 'Alimenté par WeatherAPI.com';

  @override
  String get currentWeather => 'Météo Actuelle';

  @override
  String get temperature => 'Température';

  @override
  String get humidity => 'Humidité';

  @override
  String get windSpeed => 'Vitesse du Vent';

  @override
  String get rainChance => 'Chance de Pluie';

  @override
  String get uvIndex => 'Indice UV';

  @override
  String get condition => 'Condition';

  @override
  String get tenDayForecast => 'Prévisions sur 10 Jours';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String errorLoadingWeather(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get unableToLoadWeather =>
      'Impossible de charger les données météorologiques';

  @override
  String get retry => 'Réessayer';

  @override
  String get city => 'Ville';

  @override
  String get safe => 'Sûr';

  @override
  String get warning => 'Avertissement';

  @override
  String get unsafe => 'Non Sûr';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsSubtitle =>
      'Recevoir des alertes pour les bons jours de lavage';

  @override
  String get scoreBreakdown => 'Détail du score';

  @override
  String get selectedDayBreakdown => 'Détail du jour sélectionné';

  @override
  String get noRain => 'Pas de pluie';

  @override
  String get noRainCurrently => 'Pas de pluie actuellement';

  @override
  String get noSnow => 'Pas de neige';

  @override
  String get noSnowCurrently => 'Pas de neige actuellement';

  @override
  String get rainExpected => 'Pluie prévue';

  @override
  String get snowExpected => 'Neige prévue';

  @override
  String get clearWeather => 'Dégagé';

  @override
  String get loadingText => 'Chargement';

  @override
  String get goodLabel => 'Bon';

  @override
  String get badLabel => 'Mauvais';

  @override
  String get offlineMessage =>
      'Impossible de mettre à jour les prévisions. Dernières données affichées.';
}
