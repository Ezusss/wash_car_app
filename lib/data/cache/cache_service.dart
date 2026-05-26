import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_car_app/core/constants.dart';
import 'package:wash_car_app/data/models/weather_model.dart';

class CacheService {
  static const _keyForecast = 'forecast';
  static const _keyTimestamp = 'forecast_ts';
  static const _keyLocation = 'location';

  Future<void> saveForecast(WeatherForecast forecast) async {
    final prefs = await SharedPreferences.getInstance();
    // Store just the essential location info for now
    final data = {
      'location': forecast.location,
      'latitude': forecast.latitude,
      'longitude': forecast.longitude,
      'lastUpdated': forecast.lastUpdated.toIso8601String(),
    };
    await prefs.setString(_keyForecast, jsonEncode(data));
    await prefs.setInt(_keyTimestamp, DateTime.now().millisecondsSinceEpoch);
  }

  Future<Map<String, dynamic>?> getForecast() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyForecast);
    return json != null ? jsonDecode(json) as Map<String, dynamic> : null;
  }

  Future<void> saveLocation(double lat, double lon) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocation, '$lat,$lon');
  }

  Future<String?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLocation);
  }

  Future<bool> isCacheExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final ts = prefs.getInt(_keyTimestamp) ?? 0;
    return DateTime.now().millisecondsSinceEpoch - ts >
        kRefreshIntervalHours * 3600 * 1000;
  }
}