// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Quando Lavar';

  @override
  String get safeToWash => 'Seguro para Lavar';

  @override
  String get notRecommended => 'Não Recomendado';

  @override
  String get notSafe => 'Não Seguro';

  @override
  String get weatherConditionsAreGood =>
      'As condições climáticas são boas para lavar o carro.';

  @override
  String get weatherConditionsAreNotIdeal =>
      'As condições climáticas não são ideais. Considere esperar.';

  @override
  String get poorWeatherConditions =>
      'Más condições climáticas. Espere por melhores condições.';

  @override
  String bestTimeText(Object date) {
    return 'Melhor hora: $date';
  }

  @override
  String score(Object score) {
    return 'Pontuação: $score/100';
  }

  @override
  String get settings => 'Configurações';

  @override
  String get location => 'Localização';

  @override
  String get autoLocation => 'Localização Automática';

  @override
  String get useDeviceLocation => 'Usar localização do dispositivo';

  @override
  String get enterCityName => 'Digite o nome da cidade';

  @override
  String get display => 'Exibição';

  @override
  String get temperatureUnit => 'Unidade de Temperatura';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get about => 'Sobre';

  @override
  String get appVersion => 'Versão do Aplicativo';

  @override
  String get weatherData => 'Dados Climáticos';

  @override
  String get poweredByWeatherAPI => 'Desenvolvido por WeatherAPI.com';

  @override
  String get currentWeather => 'Clima Atual';

  @override
  String get temperature => 'Temperatura';

  @override
  String get humidity => 'Umidade';

  @override
  String get windSpeed => 'Velocidade do Vento';

  @override
  String get rainChance => 'Chance de Chuva';

  @override
  String get uvIndex => 'Índice UV';

  @override
  String get condition => 'Condição';

  @override
  String get tenDayForecast => 'Previsão de 10 Dias';

  @override
  String get today => 'Hoje';

  @override
  String errorLoadingWeather(Object error) {
    return 'Erro: $error';
  }

  @override
  String get unableToLoadWeather =>
      'Não foi possível carregar os dados climáticos';

  @override
  String get retry => 'Tentar Novamente';

  @override
  String get city => 'Cidade';

  @override
  String get safe => 'Seguro';

  @override
  String get warning => 'Aviso';

  @override
  String get unsafe => 'Não Seguro';

  @override
  String get notifications => 'Notificações';

  @override
  String get notificationsSubtitle =>
      'Receba avisos sobre bons dias para lavar';

  @override
  String get scoreBreakdown => 'Detalhamento da pontuação';

  @override
  String get selectedDayBreakdown => 'Detalhamento do dia selecionado';

  @override
  String get noRain => 'Sem chuva';

  @override
  String get noRainCurrently => 'Sem chuva no momento';

  @override
  String get noSnow => 'Sem neve';

  @override
  String get noSnowCurrently => 'Sem neve no momento';

  @override
  String get rainExpected => 'Chuva esperada';

  @override
  String get snowExpected => 'Neve esperada';

  @override
  String get clearWeather => 'Limpo';

  @override
  String get loadingText => 'Carregando';

  @override
  String get goodLabel => 'Bom';

  @override
  String get badLabel => 'Ruim';

  @override
  String get offlineMessage =>
      'Não foi possível atualizar a previsão. Exibindo últimos dados.';
}
