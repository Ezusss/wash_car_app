import 'package:flutter/material.dart';
import 'package:wash_car_app/core/constants.dart';
import 'package:wash_car_app/data/models/weather_model.dart';
import 'package:wash_car_app/l10n/app_localizations.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherForecast forecast;

  const WeatherDetails({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = forecast.current;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.currentWeather} — ${forecast.location}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _WeatherDetailItem(
                      label: l10n.temperature,
                      value: '${current.tempC.toStringAsFixed(1)}°C',
                      icon: Icons.thermostat,
                      isSafe: true,
                    ),
                    _WeatherDetailItem(
                      label: l10n.humidity,
                      value: '${current.humidity}%',
                      icon: Icons.opacity,
                      isSafe: current.humidity < 80,
                    ),
                    _WeatherDetailItem(
                      label: l10n.windSpeed,
                      value: '${current.windSpeedMs.toStringAsFixed(1)} m/s',
                      icon: Icons.air,
                      isSafe: current.windSpeedMs < kMaxWindSpeed,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _WeatherDetailItem(
                      label: l10n.rainChance,
                      value: '${current.rainChance.toStringAsFixed(0)}%',
                      icon: Icons.cloud_queue,
                      isSafe: current.rainChance < 20 && !current.isRaining,
                    ),
                    _WeatherDetailItem(
                      label: l10n.uvIndex,
                      value: '${current.uvIndex}',
                      icon: Icons.wb_sunny,
                      isSafe: true,
                    ),
                    _WeatherDetailItem(
                      label: l10n.condition,
                      value: current.condition,
                      icon: Icons.cloud,
                      isSafe: !current.isRaining && !current.isSnowing,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isSafe;

  const _WeatherDetailItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.isSafe,
  });

  Color _getColor() => isSafe ? kSafeColor : kUnsafeColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24, color: _getColor()),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: _getColor(),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _getColor(),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
