import 'package:wash_car_app/core/constants.dart';
import 'package:wash_car_app/data/models/weather_model.dart';

class WashRecommendationUseCase {
  int calculateScore(WeatherForecast forecast) {
    int score = 0;
    final current = forecast.current;
    final today = forecast.forecast.isNotEmpty ? forecast.forecast[0] : null;
    final tomorrow =
        forecast.forecast.length > 1 ? forecast.forecast[1] : null;
    final in48h =
        forecast.forecast.length > 2 ? forecast.forecast[2] : null;

    // Check current conditions
    if (!current.isRaining) score += 10;
    if (!current.isSnowing) score += 10;
    if (current.windSpeedMs < kMaxWindSpeed) score += 10;
    if (current.humidity < 70) score += kLowHumidity;

    // Check today's forecast
    if (today != null) {
      if (!today.hasRain) score += kNoRainNext24h;
      if (!today.hasSnow) score += 5;
      if (today.maxWindSpeed < kMaxWindSpeed) score += kLowWind;
    }

    // Check 48h forecast
    if (tomorrow != null && in48h != null) {
      if (!tomorrow.hasRain && !in48h.hasRain) {
        score += kNoRainNext48h;
      }
    }

    // Weather condition bonus
    if (current.condition.contains('Sunny') ||
        current.condition.contains('Clear') ||
        current.condition.contains('Partly cloudy')) {
      score += kSunnyCloudy;
    }

    // Negative scores
    if (current.isRaining) score += kRainExpected;
    if (current.isSnowing) score += kSnowExpected;
    if (current.condition.contains('Thunderstorm')) score += kThunderstorm;
    if (current.condition.contains('Dust') ||
        current.condition.contains('Sand')) score += kDustSand;

    // Similar checks for forecast
    if (today != null && today.hasRain) score += kRainExpected;
    if (today != null && today.hasSnow) score += kSnowExpected;

    return score.clamp(0, 100);
  }

  String getStatus(int score) {
    if (score >= 70) return 'safe';
    if (score >= 40) return 'warning';
    return 'unsafe';
  }

  WashRecommendation getRecommendation(WeatherForecast forecast) {
    final score = calculateScore(forecast);
    final status = getStatus(score);

    String recommendation;
    String explanation;
    DateTime? bestTime;
    int daysUntilGood = 0;

    if (score >= 70) {
      recommendation = 'Safe to Wash';
      explanation = 'Weather conditions are good for car washing.';
      bestTime = DateTime.now();
    } else if (score >= 40) {
      recommendation = 'Not Recommended';
      explanation = 'Weather conditions are not ideal. Consider waiting.';
      bestTime = _findBestWashDay(forecast);
      if (bestTime != null) {
        daysUntilGood = bestTime.difference(DateTime.now()).inDays;
      }
    } else {
      recommendation = 'Not Safe';
      explanation = 'Poor weather conditions. Wait for better conditions.';
      bestTime = _findBestWashDay(forecast);
      if (bestTime != null) {
        daysUntilGood = bestTime.difference(DateTime.now()).inDays;
      }
    }

    return WashRecommendation(
      score: score,
      status: status,
      recommendation: recommendation,
      explanation: explanation,
      bestTime: bestTime,
      daysUntilGood: daysUntilGood,
    );
  }

  DateTime? _findBestWashDay(WeatherForecast forecast) {
    for (final day in forecast.forecast) {
      if (day.isSafeToWash && day.rainChance < 10) {
        return day.date;
      }
    }
    return null;
  }

  Map<DateTime, int> getScoresForForecast(WeatherForecast forecast) {
    final scores = <DateTime, int>{};

    for (final day in forecast.forecast) {
      scores[day.date] = calculateScoreForDay(day);
    }

    return scores;
  }

  int calculateScoreForDay(ForecastDay day) {
    int score = 50; // Start from 50 for an even balance

    if (!day.hasRain) score += 20;
    if (!day.hasSnow) score += 10;
    if (day.maxWindSpeed < kMaxWindSpeed) score += 15;
    if (day.avgHumidity < 70) score += 10;
    if (day.rainChance < 10) score += 15;

    if (day.hasRain) score -= 40;
    if (day.hasSnow) score -= 30;
    if (day.maxWindSpeed >= kMaxWindSpeed) score -= 15;
    if (day.avgHumidity >= 80) score -= 10;
    if (day.rainChance >= 50) score -= 20;

    return score.clamp(0, 100);
  }

  WashRecommendation getRecommendationForDay(ForecastDay day) {
    final score = calculateScoreForDay(day);
    final status = getStatus(score);

    String recommendation;
    String explanation;

    if (score >= 70) {
      recommendation = 'Safe to Wash';
      explanation = 'The selected day looks good for washing your car.';
    } else if (score >= 40) {
      recommendation = 'Not Recommended';
      explanation = 'The selected day has some conditions that may not be ideal.';
    } else {
      recommendation = 'Not Safe';
      explanation = 'The selected day has poor weather conditions for washing.';
    }

    return WashRecommendation(
      score: score,
      status: status,
      recommendation: recommendation,
      explanation: explanation,
      bestTime: day.date,
      daysUntilGood: 0,
    );
  }
}
