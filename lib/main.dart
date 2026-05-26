import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_car_app/core/constants.dart';
import 'package:wash_car_app/l10n/app_localizations.dart';
import 'package:wash_car_app/presentation/providers/weather_providers.dart';
import 'package:wash_car_app/presentation/screens/home_screen.dart';
import 'package:wash_car_app/presentation/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AdMob
  await MobileAds.instance.initialize();

  // Initialize Firebase — requires google-services.json (Android) / GoogleService-Info.plist (iOS)
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase not configured yet; analytics silently disabled
  }

  // Load persisted settings to provide as initial provider values
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        selectedCityProvider.overrideWith(
          (ref) => prefs.getString('selected_city'),
        ),
        temperatureUnitProvider.overrideWith(
          (ref) => prefs.getString('temp_unit') ?? 'C',
        ),
        notificationsEnabledProvider.overrideWith(
          (ref) => prefs.getBool('notifications_enabled') ?? false,
        ),
        useAutoLocationProvider.overrideWith(
          (ref) => prefs.getBool('use_auto_location') ?? true,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'When to Wash',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kSafeColor,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: kSafeColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kSafeColor,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kSafeColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
