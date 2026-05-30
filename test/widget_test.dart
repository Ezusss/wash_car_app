import 'package:flutter_test/flutter_test.dart';
import 'package:wash_car_app/data/models/weather_model.dart';
import 'package:wash_car_app/domain/usecases/wash_recommendation_usecase.dart';

WeatherData _makeWeatherData({
  double tempC = 20,
  int humidity = 50,
  double windSpeedMs = 5,
  double rainChance = 10,
  String condition = 'Sunny',
  bool isRaining = false,
  bool isSnowing = false,
}) =>
    WeatherData(
      tempC: tempC,
      tempF: tempC * 9 / 5 + 32,
      humidity: humidity,
      windSpeedMs: windSpeedMs,
      rainChance: rainChance,
      condition: condition,
      isRaining: isRaining,
      isSnowing: isSnowing,
      uvIndex: 3,
      dateTime: DateTime.now(),
    );

ForecastDay _makeForecastDay({
  int offsetDays = 0,
  double rainChance = 5,
  bool hasRain = false,
  bool hasSnow = false,
  double maxWindSpeed = 6,
  double avgHumidity = 55,
  int score = 80,
  String status = 'safe',
}) =>
    ForecastDay(
      date: DateTime.now().add(Duration(days: offsetDays)),
      maxTempC: 22,
      minTempC: 18,
      avgHumidity: avgHumidity,
      maxWindSpeed: maxWindSpeed,
      rainChance: rainChance,
      rainMm: 0,
      condition: 'Sunny',
      hasRain: hasRain,
      hasSnow: hasSnow,
      score: score,
      status: status,
      hourly: [],
    );

WeatherForecast _makeForecast({
  required WeatherData current,
  required List<ForecastDay> days,
  int washScore = 80,
  String washStatus = 'safe',
}) =>
    WeatherForecast(
      current: current,
      forecast: days,
      location: 'Test City',
      latitude: 40.0,
      longitude: -74.0,
      lastUpdated: DateTime.now(),
      washScore: washScore,
      washStatus: washStatus,
    );

void main() {
  group('WashRecommendationUseCase', () {
    late WashRecommendationUseCase useCase;

    setUp(() => useCase = WashRecommendationUseCase());

    test('Safe conditions return safe status and high score', () {
      final forecast = _makeForecast(
        current: _makeWeatherData(),
        days: [_makeForecastDay(score: 90, status: 'safe')],
        washScore: 90,
        washStatus: 'safe',
      );

      final rec = useCase.getRecommendation(forecast);
      expect(rec.status, 'safe');
      expect(rec.score, greaterThanOrEqualTo(70));
    });

    test('Rainy conditions return unsafe status and low score', () {
      final forecast = _makeForecast(
        current: _makeWeatherData(
          humidity: 85,
          rainChance: 90,
          condition: 'Heavy rain',
          isRaining: true,
        ),
        days: [
          _makeForecastDay(
            rainChance: 95,
            hasRain: true,
            score: 10,
            status: 'unsafe',
          )
        ],
        washScore: 10,
        washStatus: 'unsafe',
      );

      final rec = useCase.getRecommendation(forecast);
      expect(rec.status, 'unsafe');
      expect(rec.score, lessThan(40));
    });

    test('Strong wind reduces score below safe threshold', () {
      final forecast = _makeForecast(
        current: _makeWeatherData(windSpeedMs: 15),
        days: [_makeForecastDay(maxWindSpeed: 16, score: 55, status: 'warning')],
        washScore: 55,
        washStatus: 'warning',
      );

      final rec = useCase.getRecommendation(forecast);
      expect(rec.score, lessThan(70));
    });

    test('Snow conditions return unsafe status', () {
      final forecast = _makeForecast(
        current: _makeWeatherData(isSnowing: true, condition: 'Blizzard'),
        days: [
          _makeForecastDay(hasSnow: true, score: 5, status: 'unsafe')
        ],
        washScore: 5,
        washStatus: 'unsafe',
      );

      final rec = useCase.getRecommendation(forecast);
      expect(rec.status, 'unsafe');
    });

    test('getScoresForForecast returns map with one entry per day', () {
      final days = List.generate(
        10,
        (i) => _makeForecastDay(
          offsetDays: i,
          score: 90 - i * 5,
          status: (90 - i * 5) >= 70 ? 'safe' : 'warning',
        ),
      );

      final forecast = _makeForecast(
        current: _makeWeatherData(),
        days: days,
        washScore: 90,
        washStatus: 'safe',
      );

      final scores = useCase.getScoresForForecast(forecast);
      expect(scores.length, 10);

      final scoresList = scores.values.toList();
      expect(scoresList.first, greaterThanOrEqualTo(scoresList.last));
    });
  });
}
