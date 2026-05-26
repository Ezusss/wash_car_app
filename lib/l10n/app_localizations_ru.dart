// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Когда мыть';

  @override
  String get safeToWash => 'Безопасно мыть';

  @override
  String get notRecommended => 'Не рекомендуется';

  @override
  String get notSafe => 'Небезопасно';

  @override
  String get weatherConditionsAreGood =>
      'Погодные условия хороши для мытья автомобиля.';

  @override
  String get weatherConditionsAreNotIdeal =>
      'Погодные условия неидеальны. Рассмотрите возможность ожидания.';

  @override
  String get poorWeatherConditions =>
      'Плохие погодные условия. Дождитесь лучших условий.';

  @override
  String bestTimeText(Object date) {
    return 'Лучшее время: $date';
  }

  @override
  String score(Object score) {
    return 'Оценка: $score/100';
  }

  @override
  String get settings => 'Настройки';

  @override
  String get location => 'Местоположение';

  @override
  String get autoLocation => 'Автоматическое местоположение';

  @override
  String get useDeviceLocation => 'Использовать местоположение устройства';

  @override
  String get enterCityName => 'Введите название города';

  @override
  String get display => 'Дисплей';

  @override
  String get temperatureUnit => 'Единица температуры';

  @override
  String get celsius => 'Цельсий (°C)';

  @override
  String get fahrenheit => 'Фаренгейт (°F)';

  @override
  String get about => 'О приложении';

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get weatherData => 'Данные о погоде';

  @override
  String get poweredByWeatherAPI => 'Питается от WeatherAPI.com';

  @override
  String get currentWeather => 'Текущая погода';

  @override
  String get temperature => 'Температура';

  @override
  String get humidity => 'Влажность';

  @override
  String get windSpeed => 'Скорость ветра';

  @override
  String get rainChance => 'Вероятность дождя';

  @override
  String get uvIndex => 'УФ-индекс';

  @override
  String get condition => 'Условие';

  @override
  String get tenDayForecast => 'Прогноз на 10 дней';

  @override
  String get today => 'Сегодня';

  @override
  String errorLoadingWeather(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get unableToLoadWeather => 'Не удалось загрузить данные о погоде';

  @override
  String get retry => 'Повторить';

  @override
  String get city => 'Город';

  @override
  String get safe => 'Безопасно';

  @override
  String get warning => 'Предупреждение';

  @override
  String get unsafe => 'Небезопасно';

  @override
  String get notifications => 'Уведомления';

  @override
  String get notificationsSubtitle =>
      'Получайте уведомления о хороших днях для мойки';

  @override
  String get scoreBreakdown => 'Разбивка оценки';

  @override
  String get selectedDayBreakdown => 'Разбивка выбранного дня';

  @override
  String get noRain => 'Нет дождя';

  @override
  String get noRainCurrently => 'Дождя нет';

  @override
  String get noSnow => 'Нет снега';

  @override
  String get noSnowCurrently => 'Снега нет';

  @override
  String get rainExpected => 'Ожидается дождь';

  @override
  String get snowExpected => 'Ожидается снег';

  @override
  String get clearWeather => 'Ясно';

  @override
  String get loadingText => 'Загрузка';

  @override
  String get goodLabel => 'Хорошо';

  @override
  String get badLabel => 'Плохо';

  @override
  String get offlineMessage =>
      'Не удалось обновить прогноз. Показываются последние данные.';
}
