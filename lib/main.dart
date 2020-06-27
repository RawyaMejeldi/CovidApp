import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/LoginCard.dart';
import './screens/LoginScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'screens/aboutUs.dart';
import 'screens/home.dart';
import 'screens/information.dart';
import 'screens/yourLocation.dart';

void main() async {
  runApp(MyApp());
  final _auth = FirebaseAuth.instance;
  var geolocator = Geolocator();
  var authRes = await _auth.currentUser();
  final prefs = await SharedPreferences.getInstance();
  var location = json.decode(prefs.getString('location'));
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  geolocator
      .getPositionStream(locationOptions)
      .listen((Position position) async {
    if (position != null) {
      double distanceInMeters = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          location['lat'],
          location['long']);
      if (distanceInMeters > 100) {
        await Firestore.instance
            .collection('User break rules')
            .document(authRes.uid)
            .setData({'lat': position.latitude, 'long': position.longitude});
      }
    }
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Color.fromRGBO(167, 233, 233, 1),
          primaryColor: Color.fromRGBO(13, 62, 65, 1),
          primaryColorLight: Color.fromRGBO(41, 163, 163, 1),
        ),
        title: 'Télésuivi covid-19',
        // home: LogInCard(),
        home: SafeArea(
          child: StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (ctx, userSnapshot) {
                // if (userSnapshot.connectionState == ConnectionState.waiting) {
                //   return SplashScreen();
                // }
                if (userSnapshot.hasData) {
                  return Home();
                }
                return LogInCard();
              }),
        ),
        routes: {
          LoginScreen.pageRoute: (_) => LoginScreen(),
          Home.pageRoute: (_) => Home(),
          AboutUs.pageRoute: (_) => AboutUs(),
          Information.pageRoute: (_) => Information(),
          YourLocation.pageRoute: (_) => YourLocation()
        });
  }
}
