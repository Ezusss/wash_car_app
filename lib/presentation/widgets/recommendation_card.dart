import 'package:flutter/material.dart';
import 'package:wash_car_app/core/constants.dart';
import 'package:wash_car_app/data/models/weather_model.dart';
import 'package:wash_car_app/l10n/app_localizations.dart';

class RecommendationCard extends StatelessWidget {
  final WashRecommendation recommendation;

  const RecommendationCard({
    super.key,
    required this.recommendation,
  });

  Color _getStatusColor() {
    switch (recommendation.status) {
      case 'safe':
        return kSafeColor;
      case 'warning':
        return kWarnColor;
      case 'unsafe':
        return kUnsafeColor;
      default:
        return kNeutralColor;
    }
  }

  IconData _getStatusIcon() {
    switch (recommendation.status) {
      case 'safe':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning;
      case 'unsafe':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _getLocalizedTitle(AppLocalizations l10n) {
    switch (recommendation.status) {
      case 'safe':
        return l10n.safeToWash;
      case 'warning':
        return l10n.notRecommended;
      case 'unsafe':
        return l10n.notSafe;
      default:
        return recommendation.recommendation;
    }
  }

  String _getLocalizedExplanation(AppLocalizations l10n) {
    switch (recommendation.status) {
      case 'safe':
        return l10n.weatherConditionsAreGood;
      case 'warning':
        return l10n.weatherConditionsAreNotIdeal;
      case 'unsafe':
        return l10n.poorWeatherConditions;
      default:
        return recommendation.explanation;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = _getStatusColor();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.05),
            ],
          ),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(_getStatusIcon(), size: 64, color: color),
            const SizedBox(height: 16),
            Text(
              _getLocalizedTitle(l10n),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _getLocalizedExplanation(l10n),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                l10n.score(recommendation.score),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            if (recommendation.bestTime != null && recommendation.status != 'safe')
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  l10n.bestTimeText(
                    recommendation.bestTime!.toString().split(' ')[0],
                  ),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
