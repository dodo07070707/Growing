import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';

final notifications = FlutterLocalNotificationsPlugin();
late SharedPreferences prefs;

Future<void> initNotification() async {
  AndroidInitializationSettings androidSetting =
      const AndroidInitializationSettings('notification_icon');

  prefs = await SharedPreferences.getInstance();

  InitializationSettings initializationSettings = InitializationSettings(
    android: androidSetting,
  );
  await notifications.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (payload) {},
  );

  PermissionStatus status = await Permission.notification.status;
  if (status.isPermanentlyDenied || status.isGranted) return;
  await Permission.notification.request();
}

Future<void> setNotification() async {
  prefs = await SharedPreferences.getInstance();
  await prefs.setBool('entireNotificationenable', true);
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // 시간대 데이터 초기화
  tz.initializeTimeZones();

  const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
  );

  // 현재 시간 기준으로 새벽 12시 설정
  final now = tz.TZDateTime.now(tz.local);

  //final scheduledTime = tz.TZDateTime(tz.local, now.year, now.month, now.day + 1, 0, 0, 0); // 12:00 AM (새벽 12시)
  final scheduledTime =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 6, 11, 0);

  print("Current Time: $now");
  print("Scheduled Time: $scheduledTime");

  const notificationDetails =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  flutterLocalNotificationsPlugin.zonedSchedule(
      1, // 알림 ID
      '알림',
      '알림 내용',
      //scheduledTime,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

Future<void> unsetNotification() async {
  prefs = await SharedPreferences.getInstance();
  await prefs.setBool('entireNotificationenable', false);
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.cancel(0); // 알림 ID를 사용하여 알림 취소
}
