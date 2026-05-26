import 'package:flutter/material.dart';

// Colors
const kSafeColor = Color(0xFF4CAF50); // Green
const kWarnColor = Color(0xFFFF9800); // Orange
const kUnsafeColor = Color(0xFFF44336); // Red
const kNeutralColor = Color(0xFF9E9E9E); // Gray

// API Configuration — pass via --dart-define=WEATHER_API_KEY=your_key at build time
// Get a free key at https://www.weatherapi.com/
const kWeatherApiKey = String.fromEnvironment(
  'WEATHER_API_KEY',
  defaultValue: '',
);
const kRefreshIntervalHours = 3;

// Weather Thresholds
const double kMaxRainProbability = 20.0; // %
const double kMaxWindSpeed = 12.0; // m/s

// Wash Score Constants
const int kNoRainNext24h = 40;
const int kNoRainNext48h = 25;
const int kLowHumidity = 10;
const int kLowWind = 10;
const int kSunnyCloudy = 15;

const int kRainExpected = -50;
const int kThunderstorm = -70;
const int kSnowExpected = -40;
const int kDustSand = -20;

// WeatherAPI.com condition codes for rain (precipitation)
const kRainCodes = {
  1063, 1150, 1153, 1168, 1171, 1180, 1183, 1186,
  1189, 1192, 1195, 1198, 1201, 1240, 1243, 1246,
  1249, 1252,
};

// WeatherAPI.com condition codes for snow
const kSnowCodes = {
  1066, 1114, 1117, 1210, 1213, 1216, 1219, 1222,
  1225, 1255, 1258, 1279, 1282,
};

// WeatherAPI.com condition codes for thunderstorm
const kThunderstormCodes = {1087, 1273, 1276, 1279, 1282};