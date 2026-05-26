// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Cuándo Lavar';

  @override
  String get safeToWash => 'Seguro Lavar';

  @override
  String get notRecommended => 'No Recomendado';

  @override
  String get notSafe => 'No Seguro';

  @override
  String get weatherConditionsAreGood =>
      'Las condiciones climáticas son buenas para lavar el automóvil.';

  @override
  String get weatherConditionsAreNotIdeal =>
      'Las condiciones climáticas no son ideales. Considera esperar.';

  @override
  String get poorWeatherConditions =>
      'Malas condiciones climáticas. Espera mejores condiciones.';

  @override
  String bestTimeText(Object date) {
    return 'Mejor momento: $date';
  }

  @override
  String score(Object score) {
    return 'Puntuación: $score/100';
  }

  @override
  String get settings => 'Configuración';

  @override
  String get location => 'Ubicación';

  @override
  String get autoLocation => 'Ubicación Automática';

  @override
  String get useDeviceLocation => 'Usar ubicación del dispositivo';

  @override
  String get enterCityName => 'Ingrese el nombre de la ciudad';

  @override
  String get display => 'Pantalla';

  @override
  String get temperatureUnit => 'Unidad de Temperatura';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get about => 'Acerca de';

  @override
  String get appVersion => 'Versión de la aplicación';

  @override
  String get weatherData => 'Datos climáticos';

  @override
  String get poweredByWeatherAPI => 'Impulsado por WeatherAPI.com';

  @override
  String get currentWeather => 'Clima Actual';

  @override
  String get temperature => 'Temperatura';

  @override
  String get humidity => 'Humedad';

  @override
  String get windSpeed => 'Velocidad del Viento';

  @override
  String get rainChance => 'Probabilidad de Lluvia';

  @override
  String get uvIndex => 'Índice UV';

  @override
  String get condition => 'Condición';

  @override
  String get tenDayForecast => 'Pronóstico de 10 días';

  @override
  String get today => 'Hoy';

  @override
  String errorLoadingWeather(Object error) {
    return 'Error: $error';
  }

  @override
  String get unableToLoadWeather => 'No se puede cargar los datos climáticos';

  @override
  String get retry => 'Reintentar';

  @override
  String get city => 'Ciudad';

  @override
  String get safe => 'Seguro';

  @override
  String get warning => 'Advertencia';

  @override
  String get unsafe => 'No Seguro';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get notificationsSubtitle =>
      'Recibe avisos sobre buenos días para lavar';

  @override
  String get scoreBreakdown => 'Desglose de puntuación';

  @override
  String get selectedDayBreakdown => 'Desglose del día seleccionado';

  @override
  String get noRain => 'Sin lluvia';

  @override
  String get noRainCurrently => 'Sin lluvia actualmente';

  @override
  String get noSnow => 'Sin nieve';

  @override
  String get noSnowCurrently => 'Sin nieve actualmente';

  @override
  String get rainExpected => 'Lluvia esperada';

  @override
  String get snowExpected => 'Nieve esperada';

  @override
  String get clearWeather => 'Despejado';

  @override
  String get loadingText => 'Cargando';

  @override
  String get goodLabel => 'Bien';

  @override
  String get badLabel => 'Mal';

  @override
  String get offlineMessage =>
      'No se puede actualizar el pronóstico. Mostrando últimos datos.';
}
