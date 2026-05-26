import 'package:flutter/material.dart';
import 'package:wash_car_app/core/constants.dart';
import 'package:wash_car_app/data/models/weather_model.dart';
import 'package:wash_car_app/l10n/app_localizations.dart';

class WashScoreDetails extends StatelessWidget {
  final WeatherForecast forecast;
  final ForecastDay? selectedDay;

  const WashScoreDetails({
    super.key,
    required this.forecast,
    this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final showSelectedDay = selectedDay != null;
    final day = selectedDay ?? (forecast.forecast.isNotEmpty ? forecast.forecast[0] : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          showSelectedDay ? l10n.selectedDayBreakdown : l10n.scoreBreakdown,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _ScoreFactorRow(
                  label: showSelectedDay ? l10n.noRain : l10n.noRainCurrently,
                  icon: Icons.cloud_off,
                  isMet: day != null ? !day.hasRain : true,
                  value: day != null
                      ? (day.hasRain ? l10n.rainExpected : l10n.clearWeather)
                      : l10n.loadingText,
                ),
                const Divider(),
                _ScoreFactorRow(
                  label: showSelectedDay ? l10n.noSnow : l10n.noSnowCurrently,
                  icon: Icons.ac_unit,
                  isMet: day != null ? !day.hasSnow : true,
                  value: day != null
                      ? (day.hasSnow ? l10n.snowExpected : l10n.noSnow)
                      : l10n.loadingText,
                ),
                const Divider(),
                _ScoreFactorRow(
                  label: l10n.windSpeed,
                  icon: Icons.air,
                  isMet: day != null ? day.maxWindSpeed < kMaxWindSpeed : true,
                  value: day != null
                      ? '${day.maxWindSpeed.toStringAsFixed(1)} m/s'
                      : l10n.loadingText,
                  threshold: '< $kMaxWindSpeed m/s',
                ),
                const Divider(),
                _ScoreFactorRow(
                  label: l10n.humidity,
                  icon: Icons.opacity,
                  isMet: day != null ? day.avgHumidity < 80 : true,
                  value: day != null
                      ? '${day.avgHumidity.toStringAsFixed(0)}%'
                      : l10n.loadingText,
                  threshold: '< 80%',
                ),
                const Divider(),
                _ScoreFactorRow(
                  label: l10n.rainChance,
                  icon: Icons.cloud_queue,
                  isMet: day != null ? day.rainChance < 20 && !day.hasRain : true,
                  value: day != null
                      ? '${day.rainChance.toStringAsFixed(0)}%'
                      : l10n.loadingText,
                  threshold: '< 20%',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ScoreFactorRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isMet;
  final String value;
  final String? threshold;

  const _ScoreFactorRow({
    required this.label,
    required this.icon,
    required this.isMet,
    required this.value,
    this.threshold,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = isMet ? kSafeColor : kUnsafeColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                if (threshold != null)
                  Text(
                    threshold!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isMet ? '✓ ${l10n.goodLabel}' : '✗ ${l10n.badLabel}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
