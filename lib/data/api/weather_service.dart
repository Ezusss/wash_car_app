import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wash_car_app/core/errors.dart';
import 'package:wash_car_app/data/models/weather_model.dart';

class WeatherService {
  static const String _baseUrl = 'https://washcarbackend-production.up.railway.app/api';

  Future<WeatherForecast> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    return _fetch('$_baseUrl/weather/forecast?q=$latitude,$longitude&days=10');
  }

  Future<WeatherForecast> getWeatherByCity(String city) async {
    return _fetch('$_baseUrl/weather/forecast?q=${Uri.encodeComponent(city)}&days=10');
  }

  Future<WeatherForecast> _fetch(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw NetworkException(message: 'Request timeout'),
          );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return WeatherForecast.fromJson(json);
      } else if (response.statusCode == 400) {
        throw WeatherException(message: 'Invalid location');
      } else {
        throw WeatherException(
          message: 'Failed to fetch weather: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is WeatherException || e is NetworkException) rethrow;
      throw WeatherException(message: e.toString());
    }
  }
}
