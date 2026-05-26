class AppException implements Exception {
  final String message;
  final String? code;

  AppException({required this.message, this.code});

  @override
  String toString() => message;
}

class LocationException extends AppException {
  LocationException({required super.message}) : super(code: 'LOCATION_ERROR');
}

class WeatherException extends AppException {
  WeatherException({required super.message}) : super(code: 'WEATHER_ERROR');
}

class NetworkException extends AppException {
  NetworkException({required super.message}) : super(code: 'NETWORK_ERROR');
}

class CacheException extends AppException {
  CacheException({required super.message}) : super(code: 'CACHE_ERROR');
}
