import 'package:wash_car_app/data/models/weather_model.dart';

class WashRecommendationUseCase {
  WashRecommendation getRecommendation(WeatherForecast forecast) {
    final score = forecast.washScore;
    final status = forecast.washStatus;
    final bestTime = _findBestWashDay(forecast);

    return WashRecommendation(
      score: score,
      status: status,
      recommendation: _recommendationText(status),
      explanation: _explanationText(status),
      bestTime: bestTime,
      daysUntilGood: bestTime != null
          ? bestTime.difference(DateTime.now()).inDays
          : 0,
    );
  }

  WashRecommendation getRecommendationForDay(ForecastDay day) {
    return WashRecommendation(
      score: day.score,
      status: day.status,
      recommendation: _recommendationText(day.status),
      explanation: _explanationText(day.status),
      bestTime: day.date,
      daysUntilGood: 0,
    );
  }

  Map<DateTime, int> getScoresForForecast(WeatherForecast forecast) {
    return {for (final day in forecast.forecast) day.date: day.score};
  }

  DateTime? _findBestWashDay(WeatherForecast forecast) {
    for (final day in forecast.forecast) {
      if (day.isSafeToWash && day.rainChance < 10) return day.date;
    }
    return null;
  }

  String _recommendationText(String status) {
    switch (status) {
      case 'safe':
        return 'Safe to Wash';
      case 'warning':
        return 'Not Recommended';
      default:
        return 'Not Safe';
    }
  }

  String _explanationText(String status) {
    switch (status) {
      case 'safe':
        return 'Weather conditions are good for car washing.';
      case 'warning':
        return 'Weather conditions are not ideal. Consider waiting.';
      default:
        return 'Poor weather conditions. Wait for better conditions.';
    }
  }
}
