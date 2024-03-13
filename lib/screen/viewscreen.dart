import 'package:flutter/material.dart';
import 'package:flutter_calender/database/dbhelper.dart';
import 'package:flutter_calender/model/event.dart';
import 'package:flutter_calender/screen/selectevent.dart';
import 'package:flutter_calender/services/notificationService.dart';
import 'package:flutter_calender/utils/formatdate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ViewScreen extends StatefulWidget {
  final Event event;
  const ViewScreen({super.key, required this.event});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  TextEditingController eventTitle = TextEditingController();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventTitle.text = widget.event.title.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            //  SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    Selectevent(event: widget.event,colorLabel: true,)));
                      },
                      icon: const Icon(Icons.edit)),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () async {
                        print("id or wot");
                        print(widget.event.id.toString());
                        DBHelper().delete(widget.event.id!);
                        NotificationService()
                            .deleteNotification(widget.event.id!);

                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete)),
                ],
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                  visible: widget.event.eventType == "Task",
                  child: Padding(
                      padding: EdgeInsets.only(left: 38),
                      child: Text("My Task"))),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Icon(
                      Icons.square_rounded,
                      color:
                          Color(int.parse(widget.event.background.toString())),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: SelectableText(
                      widget.event.title.toString(),
                      style: const TextStyle(fontSize: 28),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  leading:
                      Text(widget.event.eventType == 'Event' ? "From" : "Date",
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                  trailing: widget.event.eventType == 'Event'
                      ? Text(
                          FormatDate.toDateTIme(
                              DateTime.parse(widget.event.fromDate.toString())),
                          style: TextStyle(fontSize: 15),
                        )
                      : Text(
                          FormatDate.toDate(
                              DateTime.parse(widget.event.fromDate.toString())),
                          style: const TextStyle(fontSize: 20),
                        )),
              Visibility(
                visible: widget.event.eventType == 'Event',
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  leading: const Text("To",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  trailing: Text(
                    FormatDate.toDateTIme(
                        DateTime.parse(widget.event.toDate.toString())),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
