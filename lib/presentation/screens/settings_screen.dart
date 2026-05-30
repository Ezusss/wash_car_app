import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_car_app/l10n/app_localizations.dart';
import 'package:wash_car_app/presentation/providers/weather_providers.dart';
import 'package:wash_car_app/services/background_service.dart';
import 'package:wash_car_app/services/notification_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveNullableString(String key, String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value != null && value.isNotEmpty) {
      await prefs.setString(key, value);
    } else {
      await prefs.remove(key);
    }
  }

  Future<void> _handleNotificationToggle(WidgetRef ref, bool value) async {
    // Optimistically update the switch.
    ref.read(notificationsEnabledProvider.notifier).state = value;

    if (value) {
      final granted = await NotificationService.requestPermission();
      if (!granted) {
        // Permission denied — revert.
        ref.read(notificationsEnabledProvider.notifier).state = false;
        await _saveBool('notifications_enabled', false);
        return;
      }
      await _saveBool('notifications_enabled', true);
      await BackgroundService.scheduleDaily();
    } else {
      await _saveBool('notifications_enabled', false);
      await BackgroundService.cancel();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final useAutoLocation = ref.watch(useAutoLocationProvider);
    final tempUnit = ref.watch(temperatureUnitProvider);
    final notificationsEnabled = ref.watch(notificationsEnabledProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Section
              Text(
                l10n.location,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: Text(l10n.autoLocation),
                subtitle: Text(l10n.useDeviceLocation),
                value: useAutoLocation,
                onChanged: (value) {
                  ref.read(useAutoLocationProvider.notifier).state = value;
                  _saveBool('use_auto_location', value);
                },
              ),
              const SizedBox(height: 12),
              if (!useAutoLocation)
                TextField(
                  decoration: InputDecoration(
                    labelText: l10n.city,
                    hintText: l10n.enterCityName,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                  ),
                  onChanged: (value) {
                    ref.read(selectedCityProvider.notifier).state = value;
                    _saveNullableString('selected_city', value);
                  },
                ),
              const SizedBox(height: 24),

              // Display Section
              Text(
                l10n.display,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(l10n.temperatureUnit),
                trailing: DropdownButton<String>(
                  value: tempUnit,
                  items: [
                    DropdownMenuItem(value: 'C', child: Text(l10n.celsius)),
                    DropdownMenuItem(value: 'F', child: Text(l10n.fahrenheit)),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(temperatureUnitProvider.notifier).state = value;
                      _saveString('temp_unit', value);
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Notifications Section
              Text(
                l10n.notifications,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: Text(l10n.notifications),
                subtitle: Text(l10n.notificationsSubtitle),
                value: notificationsEnabled,
                onChanged: (value) => _handleNotificationToggle(ref, value),
              ),
              if (notificationsEnabled)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.notifications_active_outlined),
                    label: const Text('Send test notification (~10 s)'),
                    onPressed: () => BackgroundService.triggerNow(),
                  ),
                ),
              const SizedBox(height: 24),

              // About Section
              Text(
                l10n.about,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(l10n.appVersion),
                trailing: const Text('1.0.0'),
              ),
              ListTile(
                title: Text(l10n.weatherData),
                subtitle: Text(l10n.poweredByWeatherAPI),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
