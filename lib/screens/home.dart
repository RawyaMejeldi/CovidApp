import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/getColor.dart';
import '../widget/drawer.dart';
import '../widget/leftDuration.Dart';

Future<int> get lefDuration async {
  final prefs = await SharedPreferences.getInstance();
  // ignore: non_constant_identifier_names
  final start_date_iso = prefs.getString('start_date');
  // ignore: non_constant_identifier_names
  final start_date = DateTime.parse(start_date_iso);
  var difference = DateTime.now().difference(start_date).inDays;
  var leftDuration = 14 - difference;
  return leftDuration;
}

class Home extends StatefulWidget {
  static const pageRoute = './Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    track();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);
  }

  void track() {
    print(':::::::::::::start tracking:::::::::::::');
    Geofence.startListening(GeolocationEvent.entry, (entry) {
      print('::::::::::::::::::::::::::went back:::::::::::::::::::::');
      scheduleNotification("merci de revenir", "Welcome to: ${entry.id}");
    });
    Geofence.startListening(GeolocationEvent.exit, (entry) async {
      print('::::::::::::::::::::::out of the fence:::::::::::::::::::::::');
      final _auth = FirebaseAuth.instance;
      var authRes = await _auth.currentUser();
      print('adding to DB');
      await Firestore.instance
          .collection('Users_break_rules')
          .document(authRes.uid)
          .setData({'lat': entry.latitude, 'long': entry.longitude});
      scheduleNotification(
          "SVP de retourner vers la zone definie", "Urgence: ${entry.id}");
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    print(':::::::::::::::initialization location:::::::::::::::::::');
    Geofence.initialize();
    Geofence.requestPermissions();
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('location');
    var location = jsonDecode(jsonString);
    print('::::::::::::printing location:::::::::::::');
    print(location);
    Geofence.addGeolocation(
            Geolocation(
                latitude: location['lat'],
                longitude: location['long'],
                radius: 50.0,
                id: 'home'),
            GeolocationEvent.exit)
        .then((onValue) {
      print('::::::::::::::::::::::GEO added::::::::::::::::::::');
      scheduleNotification(
          "GPS est activer", "votre location est en cours de suivis");
    }).catchError((error) {
      print("failed with $error");
    });
  }

  void scheduleNotification(String title, String subtitle) {
    Future.delayed(Duration(seconds: 5)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.Max,
          priority: Priority.High,
          ticker: 'ticker');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          0, title, subtitle, platformChannelSpecifics,
          payload: 'item x');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(title: Text('#Stay at home')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 40,
                  color: Theme.of(context).accentColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'TELESUIVI COVID-19',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          height: 2,
                          fontWeight: FontWeight.w200,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    Text('#Stay_At_Home!')
                  ],
                ),
              ],
            ),
            Text(
              'Days Left',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              height: 300,
              width: double.infinity,
              child: FutureBuilder(
                future: lefDuration,
                builder: (_, AsyncSnapshot<int> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final duration = snapshot.data;
                    return CustomPaint(
                      child: Center(
                          child: Text(
                        '${duration.toString()} days left',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            letterSpacing: 1.2),
                      )),
                      foregroundPainter: LeftDuration(
                          bgColor: Colors.grey[200],
                          lineColor: getColor(context, duration / 14),
                          percent: duration / 14,
                          width: 15.0),
                    );
                  }
                },
              ),
            )
          ],
        ));
  }
}
