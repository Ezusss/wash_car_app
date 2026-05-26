import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
    Locale('ru'),
    Locale('sr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'When to Wash'**
  String get appTitle;

  /// No description provided for @safeToWash.
  ///
  /// In en, this message translates to:
  /// **'Safe to Wash'**
  String get safeToWash;

  /// No description provided for @notRecommended.
  ///
  /// In en, this message translates to:
  /// **'Not Recommended'**
  String get notRecommended;

  /// No description provided for @notSafe.
  ///
  /// In en, this message translates to:
  /// **'Not Safe'**
  String get notSafe;

  /// No description provided for @weatherConditionsAreGood.
  ///
  /// In en, this message translates to:
  /// **'Weather conditions are good for car washing.'**
  String get weatherConditionsAreGood;

  /// No description provided for @weatherConditionsAreNotIdeal.
  ///
  /// In en, this message translates to:
  /// **'Weather conditions are not ideal. Consider waiting.'**
  String get weatherConditionsAreNotIdeal;

  /// No description provided for @poorWeatherConditions.
  ///
  /// In en, this message translates to:
  /// **'Poor weather conditions. Wait for better conditions.'**
  String get poorWeatherConditions;

  /// No description provided for @bestTimeText.
  ///
  /// In en, this message translates to:
  /// **'Best time: {date}'**
  String bestTimeText(Object date);

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score: {score}/100'**
  String score(Object score);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @autoLocation.
  ///
  /// In en, this message translates to:
  /// **'Auto Location'**
  String get autoLocation;

  /// No description provided for @useDeviceLocation.
  ///
  /// In en, this message translates to:
  /// **'Use device location'**
  String get useDeviceLocation;

  /// No description provided for @enterCityName.
  ///
  /// In en, this message translates to:
  /// **'Enter city name'**
  String get enterCityName;

  /// No description provided for @display.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get display;

  /// No description provided for @temperatureUnit.
  ///
  /// In en, this message translates to:
  /// **'Temperature Unit'**
  String get temperatureUnit;

  /// No description provided for @celsius.
  ///
  /// In en, this message translates to:
  /// **'Celsius (°C)'**
  String get celsius;

  /// No description provided for @fahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Fahrenheit (°F)'**
  String get fahrenheit;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @weatherData.
  ///
  /// In en, this message translates to:
  /// **'Weather Data'**
  String get weatherData;

  /// No description provided for @poweredByWeatherAPI.
  ///
  /// In en, this message translates to:
  /// **'Powered by WeatherAPI.com'**
  String get poweredByWeatherAPI;

  /// No description provided for @currentWeather.
  ///
  /// In en, this message translates to:
  /// **'Current Weather'**
  String get currentWeather;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'Wind Speed'**
  String get windSpeed;

  /// No description provided for @rainChance.
  ///
  /// In en, this message translates to:
  /// **'Rain Chance'**
  String get rainChance;

  /// No description provided for @uvIndex.
  ///
  /// In en, this message translates to:
  /// **'UV Index'**
  String get uvIndex;

  /// No description provided for @condition.
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get condition;

  /// No description provided for @tenDayForecast.
  ///
  /// In en, this message translates to:
  /// **'10-Day Forecast'**
  String get tenDayForecast;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @errorLoadingWeather.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorLoadingWeather(Object error);

  /// No description provided for @unableToLoadWeather.
  ///
  /// In en, this message translates to:
  /// **'Unable to load weather data'**
  String get unableToLoadWeather;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @safe.
  ///
  /// In en, this message translates to:
  /// **'Safe'**
  String get safe;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warn'**
  String get warning;

  /// No description provided for @unsafe.
  ///
  /// In en, this message translates to:
  /// **'Unsafe'**
  String get unsafe;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get notified about good wash days'**
  String get notificationsSubtitle;

  /// No description provided for @scoreBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Score Breakdown'**
  String get scoreBreakdown;

  /// No description provided for @selectedDayBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Selected Day Breakdown'**
  String get selectedDayBreakdown;

  /// No description provided for @noRain.
  ///
  /// In en, this message translates to:
  /// **'No Rain'**
  String get noRain;

  /// No description provided for @noRainCurrently.
  ///
  /// In en, this message translates to:
  /// **'No Rain Currently'**
  String get noRainCurrently;

  /// No description provided for @noSnow.
  ///
  /// In en, this message translates to:
  /// **'No Snow'**
  String get noSnow;

  /// No description provided for @noSnowCurrently.
  ///
  /// In en, this message translates to:
  /// **'No Snow Currently'**
  String get noSnowCurrently;

  /// No description provided for @rainExpected.
  ///
  /// In en, this message translates to:
  /// **'Rain expected'**
  String get rainExpected;

  /// No description provided for @snowExpected.
  ///
  /// In en, this message translates to:
  /// **'Snow expected'**
  String get snowExpected;

  /// No description provided for @clearWeather.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearWeather;

  /// No description provided for @loadingText.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingText;

  /// No description provided for @goodLabel.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get goodLabel;

  /// No description provided for @badLabel.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get badLabel;

  /// No description provided for @offlineMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to update forecast. Showing latest data.'**
  String get offlineMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'it',
        'pt',
        'ru',
        'sr'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sr':
      return AppLocalizationsSr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
