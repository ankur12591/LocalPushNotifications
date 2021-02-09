import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage1 extends StatefulWidget {

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {

  String _selectedParam;
  String task;
  int val;

  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitilize =  AndroidInitializationSettings('app_icon');
    var iOSinitilize =  IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();

    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotifications () async {
    var androidDetails = AndroidNotificationDetails("channel id", "Ankur Project", "This is Local Notifications");
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

//    await fltrNotification.show(0, "task", "You created a notification task", generalNotificationDetails);


    var scheduledTime;

    if(_selectedParam == "Minutes") {
      scheduledTime  = DateTime.now().add(Duration(minutes: val));
    } else  {
      scheduledTime  = DateTime.now().add(Duration(seconds: val));
    }

    fltrNotification.schedule(1, "Times Upp!!!", task, scheduledTime, generalNotificationDetails);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Local Notifications"),
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                    value: _selectedParam,
                      items: [
                        DropdownMenuItem(
                            child: Text("Seconds"),
                        value: "Seconds",),
                        DropdownMenuItem(
                            child: Text("Minutes"))
                      ],
                    hint: Text("Select your field"),
                    onChanged: (_val) {
                      setState(() {
                        _selectedParam = _val;
                      });
                    },
                  ),


                  DropdownButton(
                    value: val,
                      items: [
                        DropdownMenuItem(
                          child: Text("1"),
                        value: 1,),
                        DropdownMenuItem(
                            child: Text("2"),
                        value: 2,),
                        DropdownMenuItem(
                          child: Text("3"),
                        value: 3,),
                        DropdownMenuItem(
                            child: Text("4"),
                        value: 4,)
                      ],
                    hint: Text("Select a value"),
                    onChanged: (_val) {
                      setState(() {
                        val = _val;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20,),
              RaisedButton(
                onPressed: _showNotifications,
                child: Text( "Set Task with Notifications" ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future notificationSelected (String payload) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Notification pop up!!!"),
        )
    );
  }
}
