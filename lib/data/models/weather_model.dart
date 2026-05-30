import 'package:wash_car_app/core/constants.dart';

class WeatherData {
  final double tempC;
  final double tempF;
  final int humidity;
  final double windSpeedMs;
  final double rainChance;
  final String condition;
  final bool isRaining;
  final bool isSnowing;
  final int uvIndex;
  final DateTime dateTime;

  WeatherData({
    required this.tempC,
    required this.tempF,
    required this.humidity,
    required this.windSpeedMs,
    required this.rainChance,
    required this.condition,
    required this.isRaining,
    required this.isSnowing,
    required this.uvIndex,
    required this.dateTime,
  });

  static double _parseDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(Object? value) {
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // Parses the backend `current` object.
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      tempC: _parseDouble(json['tempC']),
      tempF: _parseDouble(json['tempF']),
      humidity: _parseInt(json['humidity']),
      windSpeedMs: _parseDouble(json['windKph']) / 3.6,
      rainChance: _parseDouble(json['rainChance']),
      condition: json['conditionText'] as String? ?? 'Unknown',
      isRaining: json['isRaining'] as bool? ?? false,
      isSnowing: json['isSnowing'] as bool? ?? false,
      uvIndex: _parseInt(json['uvIndex']),
      dateTime: DateTime.now(),
    );
  }

  Map<String, dynamic> toCacheJson() => {
        'tempC': tempC,
        'tempF': tempF,
        'humidity': humidity,
        'windSpeedMs': windSpeedMs,
        'rainChance': rainChance,
        'condition': condition,
        'isRaining': isRaining,
        'isSnowing': isSnowing,
        'uvIndex': uvIndex,
        'dateTime': dateTime.toIso8601String(),
      };

  factory WeatherData.fromCacheJson(Map<String, dynamic> json) => WeatherData(
        tempC: _parseDouble(json['tempC']),
        tempF: _parseDouble(json['tempF']),
        humidity: _parseInt(json['humidity']),
        windSpeedMs: _parseDouble(json['windSpeedMs']),
        rainChance: _parseDouble(json['rainChance']),
        condition: json['condition'] as String? ?? 'Unknown',
        isRaining: json['isRaining'] as bool? ?? false,
        isSnowing: json['isSnowing'] as bool? ?? false,
        uvIndex: _parseInt(json['uvIndex']),
        dateTime: DateTime.tryParse(json['dateTime'] as String? ?? '') ?? DateTime.now(),
      );

  bool get isSafeToWash =>
      rainChance < kMaxRainProbability && !isSnowing && windSpeedMs < kMaxWindSpeed && !isRaining;
}

class ForecastDay {
  final DateTime date;
  final double maxTempC;
  final double minTempC;
  final double avgHumidity;
  final double maxWindSpeed;
  final double rainChance;
  final double rainMm;
  final String condition;
  final bool hasRain;
  final bool hasSnow;
  final int score;
  final String status;
  final List<WeatherData> hourly;

  ForecastDay({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.avgHumidity,
    required this.maxWindSpeed,
    required this.rainChance,
    required this.rainMm,
    required this.condition,
    required this.hasRain,
    required this.hasSnow,
    required this.score,
    required this.status,
    required this.hourly,
  });

  static double _parseDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(Object? value) {
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // Parses a single day from the backend `forecast` array.
  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    final rainChance = _parseDouble(json['rainChance']);
    return ForecastDay(
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      maxTempC: _parseDouble(json['maxTempC']),
      minTempC: _parseDouble(json['minTempC']),
      avgHumidity: _parseDouble(json['avgHumidity']),
      maxWindSpeed: _parseDouble(json['maxWindKph']) / 3.6,
      rainChance: rainChance,
      rainMm: _parseDouble(json['rainMm']),
      condition: json['conditionText'] as String? ?? 'Unknown',
      hasRain: json['hasRain'] as bool? ?? false,
      hasSnow: json['hasSnow'] as bool? ?? false,
      score: _parseInt(json['score']),
      status: json['status'] as String? ?? 'unsafe',
      hourly: [],
    );
  }

  Map<String, dynamic> toCacheJson() => {
        'date': date.toIso8601String(),
        'maxTempC': maxTempC,
        'minTempC': minTempC,
        'avgHumidity': avgHumidity,
        'maxWindSpeed': maxWindSpeed,
        'rainChance': rainChance,
        'rainMm': rainMm,
        'condition': condition,
        'hasRain': hasRain,
        'hasSnow': hasSnow,
        'score': score,
        'status': status,
      };

  factory ForecastDay.fromCacheJson(Map<String, dynamic> json) {
    final rainChance = _parseDouble(json['rainChance']);
    return ForecastDay(
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      maxTempC: _parseDouble(json['maxTempC']),
      minTempC: _parseDouble(json['minTempC']),
      avgHumidity: _parseDouble(json['avgHumidity']),
      maxWindSpeed: _parseDouble(json['maxWindSpeed']),
      rainChance: rainChance,
      rainMm: _parseDouble(json['rainMm']),
      condition: json['condition'] as String? ?? 'Unknown',
      hasRain: json['hasRain'] as bool? ?? false,
      hasSnow: json['hasSnow'] as bool? ?? false,
      score: (json['score'] ?? 0) is int ? json['score'] as int : 0,
      status: json['status'] as String? ?? 'unsafe',
      hourly: [],
    );
  }

  bool get isSafeToWash =>
      rainChance < kMaxRainProbability && !hasSnow && maxWindSpeed < kMaxWindSpeed && !hasRain;
}

class WeatherForecast {
  final WeatherData current;
  final List<ForecastDay> forecast;
  final String location;
  final double latitude;
  final double longitude;
  final DateTime lastUpdated;
  final int washScore;
  final String washStatus;

  WeatherForecast({
    required this.current,
    required this.forecast,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.lastUpdated,
    required this.washScore,
    required this.washStatus,
  });

  static double _parseDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(Object? value) {
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // Parses the backend WeatherForecastResponse.
  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final forecastList = json['forecast'] as List<dynamic>? ?? [];
    final currentJson = json['current'] as Map<String, dynamic>? ?? {};

    return WeatherForecast(
      current: WeatherData.fromJson(currentJson),
      forecast: forecastList
          .map((day) => ForecastDay.fromJson(day as Map<String, dynamic>))
          .toList(),
      location: json['city'] as String? ?? 'Unknown',
      latitude: _parseDouble(json['latitude']),
      longitude: _parseDouble(json['longitude']),
      lastUpdated: DateTime.now(),
      washScore: _parseInt(json['washScore']),
      washStatus: json['washStatus'] as String? ?? 'unsafe',
    );
  }

  Map<String, dynamic> toCacheJson() => {
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'lastUpdated': lastUpdated.toIso8601String(),
        'washScore': washScore,
        'washStatus': washStatus,
        'current': current.toCacheJson(),
        'forecast': forecast.map((d) => d.toCacheJson()).toList(),
      };

  factory WeatherForecast.fromCacheJson(Map<String, dynamic> json) {
    final forecastList = json['forecast'] as List<dynamic>? ?? [];
    return WeatherForecast(
      location: json['location'] as String? ?? 'Unknown',
      latitude: _parseDouble(json['latitude']),
      longitude: _parseDouble(json['longitude']),
      lastUpdated: DateTime.tryParse(json['lastUpdated'] as String? ?? '') ?? DateTime.now(),
      washScore: (json['washScore'] ?? 0) is int ? json['washScore'] as int : 0,
      washStatus: json['washStatus'] as String? ?? 'unsafe',
      current: WeatherData.fromCacheJson(
        json['current'] as Map<String, dynamic>? ?? {},
      ),
      forecast: forecastList
          .map((d) => ForecastDay.fromCacheJson(d as Map<String, dynamic>))
          .toList(),
    );
  }
}

class WashRecommendation {
  final int score;
  final String status;
  final String recommendation;
  final String explanation;
  final DateTime? bestTime;
  final int daysUntilGood;

  WashRecommendation({
    required this.score,
    required this.status,
    required this.recommendation,
    required this.explanation,
    required this.bestTime,
    required this.daysUntilGood,
  });
}
