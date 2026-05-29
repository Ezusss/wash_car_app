import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wash_car_app/core/constants.dart';
import 'package:wash_car_app/core/errors.dart';
import 'package:wash_car_app/data/models/weather_model.dart';

class WeatherService {
  final String apiKey;
  static const String baseUrl = 'https://washcarbackend-production.up.railway.app/api';

  WeatherService({String? apiKey}) : apiKey = apiKey ?? kWeatherApiKey;

  Future<WeatherForecast> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final url = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$latitude,$longitude&days=10&aqi=no',
      );

      final response = await http.get(url).timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw NetworkException(message: 'Request timeout'),
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

  Future<WeatherForecast> getWeatherByCity(String city) async {
    try {
      final url = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$city&days=10&aqi=no',
      );

      final response = await http.get(url).timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw NetworkException(message: 'Request timeout'),
          );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return WeatherForecast.fromJson(json);
      } else if (response.statusCode == 400) {
        throw WeatherException(message: 'City not found');
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
