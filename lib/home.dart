import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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

    var scheduledTime = DateTime.now().add(Duration(seconds: 5));

    fltrNotification.schedule(0, "Task", "Scheduled notification", scheduledTime, generalNotificationDetails);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Notifications"),
      ),

      body: Center(
        child: RaisedButton(
          onPressed: _showNotifications,
          child: Text( "Local Notifications" ),
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
