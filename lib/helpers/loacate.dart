import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

void locate() async {
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
  GeolocationStatus geolocationStatus =
      await geolocator.checkGeolocationPermissionStatus();
  print('::::::::::::gps status:::::::::::::::');
  print(geolocationStatus);
  final _auth = FirebaseAuth.instance;
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
            .collection('User_break_rules')
            .document(authRes.uid)
            .setData({'lat': position.latitude, 'long': position.longitude});
      }
    }
  });
}
