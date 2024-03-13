import 'package:flutter/material.dart';
import 'package:flutter_calender/database/dbhelper.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_calender/model/event.dart';
import 'package:flutter_calender/screen/selectevent.dart';
import 'package:flutter_calender/screen/viewscreen.dart';
import 'package:flutter_calender/utils/calender.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'dart:developer' as s1;
import 'package:intl/intl.dart';

import '../services/notificationService.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    
    late DBHelper dbHelper;
    late List<Event> event=[];
    
    @override
  void initState() {
    dbHelper=DBHelper();
    getDataSource();
    NotificationService().initNotification();
    super.initState();
  }

 Future<List<Event>> getDataSource()async{

      event=await dbHelper.getEventList();
      print(event);
      setState(() {});
    return event;    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SfCalendar(
          
          view:CalendarView.schedule,
          dataSource: CalendarSource (event),
          
          firstDayOfWeek: 1,
          // cellBorderColor: Colors.transparent,
          allowViewNavigation: true,
          todayHighlightColor: const Color(0xff89d0ec),
          todayTextStyle: const TextStyle(color: Color(0xff032029)),
          showTodayButton: true,
          showDatePickerButton: true,
          headerHeight: 50,
          headerDateFormat: "MMMM",
          monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,showTrailingAndLeadingDates: false),
          appointmentTextStyle: const TextStyle(fontSize: 10),

          scheduleViewMonthHeaderBuilder:(context, details) {
            final String monthName = getMonthDate(details.date);
            // s1.log(monthName.toString());
            return Stack(
              children: [
                Image(image: AssetImage('images/$monthName.png',),fit: BoxFit.cover,width: details.bounds.width,height: details.bounds.height,),
                Positioned(top: 10,
                  left: 60,
                  child: Text("$monthName ${details.date.year}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),))
              ],
            );
          },
          allowedViews: const [
            CalendarView.day,
            CalendarView.month,
            CalendarView.week,
            CalendarView.schedule
          ],
          // monthViewSettings: MonthViewSettings(showAgenda: true),
          onTap: (calendarTapDetails) {
            if(calendarTapDetails.appointments==null) return;

            final event=calendarTapDetails.appointments!.first;
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ViewScreen(event: event))).then((value) => getDataSource());
          },
         
            
          
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Selectevent(colorLabel: false,))).then((value){
          getDataSource();
        });
      },
      
      backgroundColor: const Color(0xff324a54),
      mini: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: const Icon(Icons.add,color: Color(0xffd0e8f2),size: 30),
      ),
    );
  }

  getMonthDate(DateTime monthname){
    String monName=DateFormat.MMMM().format(monthname);
    return monName;
  }

}