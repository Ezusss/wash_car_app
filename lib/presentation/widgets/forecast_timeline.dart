import 'package:flutter/material.dart';
import 'package:wash_car_app/core/constants.dart';
import 'package:wash_car_app/data/models/weather_model.dart';
import 'package:wash_car_app/l10n/app_localizations.dart';

class ForecastTimeline extends StatelessWidget {
  final Map<DateTime, int> scores;
  final List<ForecastDay>? forecastDays;
  final ForecastDay? selectedDay;
  final void Function(ForecastDay day)? onDaySelected;

  const ForecastTimeline({
    super.key,
    required this.scores,
    this.forecastDays,
    this.selectedDay,
    this.onDaySelected,
  });

  Color _getScoreColor(int score) {
    if (score >= 70) return kSafeColor;
    if (score >= 40) return kWarnColor;
    return kUnsafeColor;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sortedScores = scores.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sortedScores.length,
        itemBuilder: (context, index) {
          final entry = sortedScores[index];
          final date = entry.key;
          final score = entry.value;
          final now = DateTime.now();
          final isToday = now.day == date.day &&
              now.month == date.month &&
              now.year == date.year;

          ForecastDay? dayForecast;
          if (forecastDays != null) {
            for (final day in forecastDays!) {
              if (day.date.day == date.day &&
                  day.date.month == date.month &&
                  day.date.year == date.year) {
                dayForecast = day;
                break;
              }
            }
          }

          final isSelected = selectedDay != null &&
              dayForecast != null &&
              selectedDay!.date.day == dayForecast.date.day &&
              selectedDay!.date.month == dayForecast.date.month &&
              selectedDay!.date.year == dayForecast.date.year;

          final color = _getScoreColor(score);

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: dayForecast != null ? () => onDaySelected?.call(dayForecast!) : null,
              child: Card(
                elevation: isToday ? 4 : 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: (isSelected || isToday)
                      ? BorderSide(color: color, width: 2)
                      : BorderSide.none,
                ),
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color.withValues(alpha: 0.1),
                        color.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isToday ? l10n.today : _formatDate(date),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          color: isToday ? color : Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                        child: Center(
                          child: Text(
                            '$score',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        _getStatusLabel(score, l10n),
                        style: TextStyle(
                          fontSize: 10,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${days[date.weekday - 1]}\n${date.day}';
  }

  String _getStatusLabel(int score, AppLocalizations l10n) {
    if (score >= 70) return l10n.safe;
    if (score >= 40) return l10n.warning;
    return l10n.unsafe;
  }
}
