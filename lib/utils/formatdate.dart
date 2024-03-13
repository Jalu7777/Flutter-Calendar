import 'package:intl/intl.dart';

// import 'dart:developer' as s1;
class FormatDate {
  static String toDateTIme(DateTime toDate) {
    String date = DateFormat('E, dd MMM yyyy hh:mm a').format(toDate);
    return date;
  }

  static String toDate(DateTime toDate) {
    String date = DateFormat('E, dd MMM yyyy').format(toDate);
    return date;
  }

  static String toTime(DateTime toTime) {
    String time = DateFormat(
      'h:mm a',
    ).format(toTime.toLocal()).toLowerCase();
    return time;
  }

  static String chnageDateFormat(DateTime date, String format) {
    String time = DateFormat(format).format(date);
    return time;
  }
}
