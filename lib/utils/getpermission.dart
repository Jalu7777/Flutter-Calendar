import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class RequestPermission {
  static Future<PermissionStatus> getNotificationPermission() async {
    final status = await Permission.notification.status;
    log('status$status');
    if (status != PermissionStatus.granted) {
      final staus = await Permission.notification.request();
      return staus;
    } else {
      return status;
    }
  }
}
