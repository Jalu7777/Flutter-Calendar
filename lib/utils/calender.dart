import 'dart:ui';
import 'dart:developer' as s1;
import 'package:flutter/material.dart';
import 'package:flutter_calender/model/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarSource extends CalendarDataSource{

  CalendarSource(List<Event> source){
    appointments=source;
    
    appointments!.forEach((element) {
      s1.log(appointments.toString());
    });
  }
@override
  Color getColor(int index) {
    // String s1=;
    return Color(
      int.parse(
      appointments![index].background
      )
    );
  }
@override
  String getSubject(int index) {
   return appointments![index].title;
   
  }
  @override
  bool isAllDay(int index) {
    if(appointments![index].eventType.toString().contains('Event')){
      return appointments![index].isAllDay??false;
    }
    else{
      return appointments![index].isAllDay??true;
    }
  }
@override
  DateTime getStartTime(int index) {
     return DateTime.parse(appointments![index].fromDate);
  }
  @override
  DateTime getEndTime(int index) {
      return DateTime.parse(appointments![index].toDate);
}
}