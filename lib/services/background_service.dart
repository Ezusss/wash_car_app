import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_service.dart';

const _backendUrl =
    'https://washcarbackend-production.up.railway.app/api/weather/forecast';

class BackgroundService {
  static Future<void> initialize() async {
    // Timezone and plugin initialization is handled in NotificationService.initialize().
  }

  static Future<void> scheduleDaily() async {
    await NotificationService.scheduleDailyAt8am();
  }

  static Future<void> cancel() async {
    await NotificationService.cancelScheduled();
  }

  /// Fetches current weather and shows a rich notification immediately.
  /// Used for the test button in settings.
  static Future<void> triggerNow() async {
    final prefs = await SharedPreferences.getInstance();
    final query = _resolveQuery(prefs);
    if (query == null) return;

    try {
      final uri = Uri.parse(
        '$_backendUrl?q=${Uri.encodeComponent(query)}&days=1',
      );
      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) return;

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final score = (json['washScore'] as num).toInt();
      final status = json['washStatus'] as String? ?? 'unsafe';
      final city = json['city'] as String? ?? query;

      await NotificationService.showWashNotification(
        score: score,
        status: status,
        location: city,
      );
    } catch (_) {}
  }
}

String? _resolveQuery(SharedPreferences prefs) {
  final city = prefs.getString('selected_city');
  if (city != null && city.isNotEmpty) return city;

  final cached = prefs.getString('weather_cache_v3');
  if (cached != null) {
    try {
      final json = jsonDecode(cached) as Map<String, dynamic>;
      final location = json['location'] as String?;
      if (location != null && location.isNotEmpty && location != 'Unknown') {
        return location;
      }
    } catch (_) {}
  }
  return null;
}
