import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocation/geolocation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

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
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);
  }

  Future<void> initPlatformState() async {
    await Geolocation.requestLocationPermission(
      permission: const LocationPermission(
        android: LocationPermissionAndroid.fine,
        ios: LocationPermissionIOS.always,
      ),
      openSettingsIfDenied: true,
    );
    final GeolocationResult result = await Geolocation.isLocationOperational();
    if (result.isSuccessful) {
      // location service is enabled, and location permission is granted
      scheduleNotification(
          "GPS est activer", "votre location est en cours de suivis");
    } else {
      // location service is not enabled, restricted, or location permission is denied
      scheduleNotification(
          "GPS est desactiver", "avertissement , vous dever activer le gps");
    }
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('location');
    var location = jsonDecode(jsonString);
    print('::::::::::::printing location:::::::::::::');
    print(location);
    print(':::::::::::::::initialization location:::::::::::::::::::');
    Geolocation.locationUpdates(
      accuracy: LocationAccuracy.best,
      displacementFilter: 10.0, // in meters
      inBackground:
          true, // by default, location updates will pause when app is inactive (in background). Set to `true` to continue updates in background.
    ).listen((result) async {
      if (result.isSuccessful) {
        double lat = result.location.latitude;
        double lng = result.location.longitude;
        num distanceBetweenPoints = SphericalUtil.computeDistanceBetween(
            LatLng(lat, lng), LatLng(location['lat'], location['long']));
        if (distanceBetweenPoints > 200) {
          print(
              '::::::::::::::::::::::out of the fence:::::::::::::::::::::::');
          final _auth = FirebaseAuth.instance;
          var authRes = await _auth.currentUser();
          print('adding to DB');
          await Firestore.instance
              .collection('Users_break_rules')
              .document(authRes.uid)
              .setData({
            'nom': authRes.displayName,
            'phone': authRes.email,
            'lat': result.location.latitude,
            'long': result.location.longitude
          });
          scheduleNotification(
              "SVP de retourner vers la zone definie", "Urgence");
        }
      } else {
        switch (result.error.type) {
          case GeolocationResultErrorType.runtime:
            // runtime error, check result.error.message
            break;
          case GeolocationResultErrorType.locationNotFound:
            // location request did not return any result
            break;
          case GeolocationResultErrorType.serviceDisabled:
            // location services disabled on device
            // might be that GPS is turned off, or parental control (android)
            break;
          case GeolocationResultErrorType.permissionNotGranted:
            // location has not been requested ye
            // app must request permission in order to access the location
            break;
          case GeolocationResultErrorType.permissionDenied:
            // user denied the location permission for the app
            // rejection is final on iOS, and can be on Android if user checks `don't ask again`
            // user will need to manually allow the app from the settings, see requestLocationPermission(openSettingsIfDenied: true)
            break;
          case GeolocationResultErrorType.playServicesUnavailable:
            // android only
            // result.error.additionalInfo contains more details on the play services error
            switch (
                result.error.additionalInfo as GeolocationAndroidPlayServices) {
              // do something, like showing a dialog inviting the user to install/update play services
              case GeolocationAndroidPlayServices.missing:
              case GeolocationAndroidPlayServices.updating:
              case GeolocationAndroidPlayServices.versionUpdateRequired:
              case GeolocationAndroidPlayServices.disabled:
              case GeolocationAndroidPlayServices.invalid:
            }
            break;
        }
      }
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
