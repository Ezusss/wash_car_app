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

  static Map<String, dynamic> _parseMap(Object? value) {
    return value is Map<String, dynamic> ? value : <String, dynamic>{};
  }

  // rainChance is sourced from today's forecast (daily_chance_of_rain) since
  // the /current endpoint does not provide a rain probability field.
  factory WeatherData.fromJson(Map<String, dynamic> json, {double rainChance = 0.0}) {
    final current = _parseMap(json['current']);
    final condition = _parseMap(current['condition']);
    final conditionCode = _parseInt(condition['code']);

    return WeatherData(
      tempC: _parseDouble(current['temp_c']),
      tempF: _parseDouble(current['temp_f']),
      humidity: _parseInt(current['humidity']),
      windSpeedMs: _parseDouble(current['wind_kph']) / 3.6,
      rainChance: rainChance,
      condition: condition['text'] as String? ?? 'Unknown',
      isRaining: kRainCodes.contains(conditionCode),
      isSnowing: kSnowCodes.contains(conditionCode),
      uvIndex: _parseInt(current['uv']),
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
    required this.hourly,
  });

  static double _parseDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static Map<String, dynamic> _parseMap(Object? value) {
    return value is Map<String, dynamic> ? value : <String, dynamic>{};
  }

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    final day = _parseMap(json['day']);
    final condition = _parseMap(day['condition']);
    final rainChance = _parseDouble(day['daily_chance_of_rain']);

    return ForecastDay(
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      maxTempC: _parseDouble(day['maxtemp_c']),
      minTempC: _parseDouble(day['mintemp_c']),
      avgHumidity: _parseDouble(day['avghumidity']),
      maxWindSpeed: _parseDouble(day['maxwind_kph']) / 3.6,
      rainChance: rainChance,
      rainMm: _parseDouble(day['totalprecip_mm']),
      condition: condition['text'] as String? ?? 'Unknown',
      hasRain: rainChance >= kMaxRainProbability,
      hasSnow: _parseDouble(day['daily_chance_of_snow']) >= kMaxRainProbability,
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
      };

  factory ForecastDay.fromCacheJson(Map<String, dynamic> json) {
    final rainChance = (json['rainChance'] ?? 0.0).toDouble();
    return ForecastDay(
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      maxTempC: (json['maxTempC'] ?? 0.0).toDouble(),
      minTempC: (json['minTempC'] ?? 0.0).toDouble(),
      avgHumidity: (json['avgHumidity'] ?? 0.0).toDouble(),
      maxWindSpeed: (json['maxWindSpeed'] ?? 0.0).toDouble(),
      rainChance: rainChance,
      rainMm: (json['rainMm'] ?? 0.0).toDouble(),
      condition: json['condition'] as String? ?? 'Unknown',
      hasRain: json['hasRain'] as bool? ?? false,
      hasSnow: json['hasSnow'] as bool? ?? false,
      hourly: [],
    );
  }

  bool get isSafeToWash =>
      rainChance < kMaxRainProbability && !hasSnow && maxWindSpeed < kMaxWindSpeed && !hasRain;
}

class WeatherForecast {
  final WeatherData current;
  final List<ForecastDay> forecast; // up to 10 days
  final String location;
  final double latitude;
  final double longitude;
  final DateTime lastUpdated;

  WeatherForecast({
    required this.current,
    required this.forecast,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.lastUpdated,
  });

  static double _parseDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static List<dynamic> _parseList(Object? value) {
    return value is List ? value : <dynamic>[];
  }

  static Map<String, dynamic> _parseMap(Object? value) {
    return value is Map<String, dynamic> ? value : <String, dynamic>{};
  }

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final forecastObj = _parseMap(json['forecast']);
    final forecastDays = _parseList(forecastObj['forecastday']);
    final location = _parseMap(json['location']);

    // Today's rain chance from first forecast day, used for current weather display.
    double todayRainChance = 0.0;
    if (forecastDays.isNotEmpty) {
      final todayDay = _parseMap(_parseMap(forecastDays[0])['day']);
      todayRainChance = _parseDouble(todayDay['daily_chance_of_rain']);
    }

    return WeatherForecast(
      current: WeatherData.fromJson(json, rainChance: todayRainChance),
      forecast: forecastDays
          .map((day) => ForecastDay.fromJson(day as Map<String, dynamic>))
          .toList(),
      location: location['name'] as String? ?? 'Unknown',
      latitude: _parseDouble(location['lat']),
      longitude: _parseDouble(location['lon']),
      lastUpdated: DateTime.now(),
    );
  }

  Map<String, dynamic> toCacheJson() => {
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'lastUpdated': lastUpdated.toIso8601String(),
        'current': current.toCacheJson(),
        'forecast': forecast.map((d) => d.toCacheJson()).toList(),
      };

  factory WeatherForecast.fromCacheJson(Map<String, dynamic> json) {
    final forecastList = json['forecast'] as List<dynamic>? ?? [];
    return WeatherForecast(
      location: json['location'] as String? ?? 'Unknown',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      lastUpdated: DateTime.tryParse(json['lastUpdated'] as String? ?? '') ?? DateTime.now(),
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
  final String status; // 'safe', 'warning', 'unsafe'
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
