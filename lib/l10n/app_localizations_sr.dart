// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get appTitle => 'Када перати';

  @override
  String get safeToWash => 'Безбедно за перање';

  @override
  String get notRecommended => 'Није препоручено';

  @override
  String get notSafe => 'Није безбедно';

  @override
  String get weatherConditionsAreGood =>
      'Временске прилике су добре за прање аутомобила.';

  @override
  String get weatherConditionsAreNotIdeal =>
      'Временске прилике нису идеалне. Размислите да чекате.';

  @override
  String get poorWeatherConditions =>
      'Лоше временске прилике. Чекајте боље услове.';

  @override
  String bestTimeText(Object date) {
    return 'Најбоље време: $date';
  }

  @override
  String score(Object score) {
    return 'Оцена: $score/100';
  }

  @override
  String get settings => 'Подешавања';

  @override
  String get location => 'Локација';

  @override
  String get autoLocation => 'Аутоматска локација';

  @override
  String get useDeviceLocation => 'Користи локацију уређаја';

  @override
  String get enterCityName => 'Унесите назив града';

  @override
  String get display => 'Екран';

  @override
  String get temperatureUnit => 'Јединица температуре';

  @override
  String get celsius => 'Целзијус (°C)';

  @override
  String get fahrenheit => 'Фаренхајт (°F)';

  @override
  String get about => 'О апликацији';

  @override
  String get appVersion => 'Верзија апликације';

  @override
  String get weatherData => 'Временски подаци';

  @override
  String get poweredByWeatherAPI => 'Захваљујући WeatherAPI.com';

  @override
  String get currentWeather => 'Тренутне временске прилике';

  @override
  String get temperature => 'Температура';

  @override
  String get humidity => 'Влажност';

  @override
  String get windSpeed => 'Брзина ветра';

  @override
  String get rainChance => 'Шанса за кишу';

  @override
  String get uvIndex => 'УВ индекс';

  @override
  String get condition => 'Услов';

  @override
  String get tenDayForecast => 'Прогноза за 10 дана';

  @override
  String get today => 'Данас';

  @override
  String errorLoadingWeather(Object error) {
    return 'Грешка: $error';
  }

  @override
  String get unableToLoadWeather => 'Није могуће учитати временске податке';

  @override
  String get retry => 'Покушај поново';

  @override
  String get city => 'Град';

  @override
  String get safe => 'Безбедно';

  @override
  String get warning => 'Упозорење';

  @override
  String get unsafe => 'Није безбедно';

  @override
  String get notifications => 'Обавештења';

  @override
  String get notificationsSubtitle =>
      'Добијајте обавештења о добрим данима за прање';

  @override
  String get scoreBreakdown => 'Разбијање резултата';

  @override
  String get selectedDayBreakdown => 'Разбијање изабраног дана';

  @override
  String get noRain => 'Нема кише';

  @override
  String get noRainCurrently => 'Тренутно нема кише';

  @override
  String get noSnow => 'Нема снега';

  @override
  String get noSnowCurrently => 'Тренутно нема снега';

  @override
  String get rainExpected => 'Очекује се киша';

  @override
  String get snowExpected => 'Очекује се снег';

  @override
  String get clearWeather => 'Ведро';

  @override
  String get loadingText => 'Учитавање';

  @override
  String get goodLabel => 'Добро';

  @override
  String get badLabel => 'Лоше';

  @override
  String get offlineMessage =>
      'Није могуће ажурирати прогнозу. Приказују се последњи подаци.';
}
