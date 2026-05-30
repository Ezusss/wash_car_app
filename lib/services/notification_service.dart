import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'wash_car_daily';
  static const _notificationId = 42;

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    try {
      final localTz = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localTz));
    } catch (_) {
      // Falls back to UTC if timezone detection fails.
    }

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
    );
  }

  static Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      return await ios.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }
    return false;
  }

  static Future<void> showWashNotification({
    required int score,
    required String status,
    required String location,
  }) async {
    final String title;
    final String body;

    if (status == 'safe') {
      title = 'Great day to wash! \u{1F697}';
      body = '$location — Score $score/100. Perfect conditions today.';
    } else if (status == 'warning') {
      title = 'Car wash conditions: OK';
      body = '$location — Score $score/100. Conditions are acceptable.';
    } else {
      title = 'Not a good day to wash';
      body = '$location — Score $score/100. Wait for better weather.';
    }

    await _plugin.show(_notificationId, title, body, _details());
  }

  /// Schedules a daily reminder at 8:00 AM in the device's local timezone.
  /// Uses [matchDateTimeComponents] so it repeats automatically every day.
  static Future<void> scheduleDailyAt8am() async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      8,
    );
    if (!scheduledDate.isAfter(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      _notificationId,
      'Time to check your car wash conditions! \u{1F697}',
      'Tap to see today\'s wash score.',
      scheduledDate,
      _details(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelScheduled() async {
    await _plugin.cancel(_notificationId);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  static NotificationDetails _details() => const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'Daily Wash Reminder',
          channelDescription: 'Daily car wash weather check at 8:00 AM',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      );
}
