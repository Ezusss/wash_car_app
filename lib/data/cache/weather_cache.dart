import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_car_app/core/errors.dart';
import 'package:wash_car_app/data/models/weather_model.dart';

class WeatherCache {
  static const String _weatherKey = 'weather_cache_v2';
  static const String _lastUpdateKey = 'weather_last_update';
  static const String _selectedCityKey = 'selected_city';

  final SharedPreferences _prefs;

  WeatherCache(this._prefs);

  Future<void> saveWeather(WeatherForecast forecast) async {
    try {
      await _prefs.setString(_weatherKey, jsonEncode(forecast.toCacheJson()));
      await _prefs.setString(
        _lastUpdateKey,
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      throw CacheException(message: 'Failed to save weather cache');
    }
  }

  WeatherForecast? getCachedWeather() {
    try {
      final cached = _prefs.getString(_weatherKey);
      if (cached == null) return null;
      final json = jsonDecode(cached) as Map<String, dynamic>;
      return WeatherForecast.fromCacheJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveSelectedCity(String city) async {
    try {
      await _prefs.setString(_selectedCityKey, city);
    } catch (e) {
      throw CacheException(message: 'Failed to save city');
    }
  }

  String? getSelectedCity() {
    return _prefs.getString(_selectedCityKey);
  }

  Future<bool> isWeatherCacheValid(int hoursThreshold) async {
    try {
      final lastUpdate = _prefs.getString(_lastUpdateKey);
      if (lastUpdate == null) return false;
      final diff = DateTime.now().difference(DateTime.parse(lastUpdate)).inHours;
      return diff < hoursThreshold;
    } catch (_) {
      return false;
    }
  }

  Future<void> clearCache() async {
    try {
      await _prefs.remove(_weatherKey);
      await _prefs.remove(_lastUpdateKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear cache');
    }
  }
}
