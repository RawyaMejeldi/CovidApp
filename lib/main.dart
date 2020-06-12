import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/LoginScreen.dart';
import './screens/LoginCard.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

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
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              if (userSnapshot.hasData) {
                return Home();
              }
              return LogInCard();
            }),
        routes: {LoginScreen.pageRoute: (_) => LoginScreen()});
  }
}
