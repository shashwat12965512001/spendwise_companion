import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidDetails =
      AndroidNotificationDetails(
        'recommendation_channel', // Channel ID
        'User Recommendations', // Channel name
        channelDescription: 'Used for financial recommendations',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

  static const NotificationDetails _platformDetails = NotificationDetails(
    android: _androidDetails,
  );

  static Future<void> showNotification(String title, String message) async {
    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique ID
      title,
      message,
      _platformDetails,
    );
  }
}
