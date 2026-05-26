import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_car_app/data/models/weather_model.dart';

class HomeWidgetService {
  static Future<void> updateWidget(
    WashRecommendation recommendation,
    WeatherForecast? forecast,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setInt('score', recommendation.score);
      await prefs.setString('status', recommendation.status);
      await prefs.setString('recommendation', recommendation.recommendation);

      if (forecast != null) {
        await prefs.setString('location', forecast.location);
        await prefs.setDouble('tempC', forecast.current.tempC);
        await prefs.setInt('humidity', forecast.current.humidity);
      }

      await HomeWidget.saveWidgetData<int>('score', recommendation.score);
      await HomeWidget.saveWidgetData<String>('status', recommendation.status);
      await HomeWidget.saveWidgetData<String>('recommendation', recommendation.recommendation);

      if (forecast != null) {
        await HomeWidget.saveWidgetData<String>('location', forecast.location);
        await HomeWidget.saveWidgetData<double>('tempC', forecast.current.tempC);
        await HomeWidget.saveWidgetData<int>('humidity', forecast.current.humidity);
      }

      await HomeWidget.updateWidget(
        name: 'HomeWidgetProvider',
        qualifiedAndroidName: 'com.ezudev.washcar.wash_car_app.HomeWidgetProvider',
      );
    } catch (_) {
      // Widget update failure is non-fatal
    }
  }
}
