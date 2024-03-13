import 'package:flutter/cupertino.dart';
import 'package:flutter_calender/utils/getpermission.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';
import 'dart:developer' as d1;
import 'package:device_info/device_info.dart';

@pragma('vm:entry-point')
void notificationTapBackground(response) {
// Navigator.push(context, MaterialPageRoute(builder: ((context) => )));
}

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    int sdk = androidInfo.version.sdkInt;
    if (sdk > 32) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
    } else {
      final status = await RequestPermission.getNotificationPermission();
      d1.log('permission$status');
    }

    final _androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final _iosInitializationSettings = DarwinInitializationSettings();

    InitializationSettings _initializationSettings = InitializationSettings(
        android: _androidInitializationSettings,
        iOS: _iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId1', 'channelName1', importance: Importance.high,
          priority: Priority.high,
          enableLights: true,
          playSound: true,

          // showWhen: true,
          // styleInformation: ,
          // color: Color(0xffFFFF00),

          visibility: NotificationVisibility.public,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return flutterLocalNotificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotificationCurrent(
      {required int id,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduleDate}) async {
    print(
        "schedule date is ${scheduleDate.subtract(Duration(seconds: scheduleDate.second, milliseconds: scheduleDate.millisecond, microseconds: scheduleDate.microsecond))}");
    print("schedule id is $id");
    if (scheduleDate.isAfter(DateTime.now())) {
      flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduleDate, tz.local),
          await notificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
    }
  }

  Future scheduleNotificationPeriodically(
      {String? title,
      String? body,
      String? payLoad,
      required DateTime scheduleDate}) async {
    return flutterLocalNotificationsPlugin.zonedSchedule(
        Random().nextInt(100000),
        title,
        body,
        tz.TZDateTime.from(scheduleDate, tz.local).add(Duration(seconds: 5)),
        await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future scheduleNotificationPeriodically1(
      {required int id,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduleDate}) async {
    return flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(scheduleDate, tz.local), await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> deleteNotification(int id) async {
    print("delete id $id");
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future scheduleNotificationBefore(
      {required int id,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduleDate}) async {
   
    print("id=$id");

    print("satisfied");
    return flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(scheduleDate, tz.local), await notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }


}
