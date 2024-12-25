import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const androidInitialization = AndroidInitializationSettings('app_icon');

    var initializationSettings = const InitializationSettings(
      android: androidInitialization,
    );
    
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'This channel is for default notifications',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
      enableVibration: true,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
  Future<void> showDailyJokeNotification(String joke) async {
    var scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

    var androidDetails = const AndroidNotificationDetails(
      'daily_joke_channel',
      'Daily Joke',
      channelDescription: 'This channel is for daily jokes notifications',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
      enableVibration: true,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Joke of the Day',
      joke,
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
    );
  }
}
