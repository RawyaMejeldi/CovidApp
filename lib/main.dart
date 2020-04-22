import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/screens/LoginScreen.dart';
import './screens/home.dart';
import './screens/LoginScreen.dart';
import 'screens/LoginCard.dart';
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
      home: LogInCard(),
     routes:{
       LoginScreen.pageRoute:(_)=>LoginScreen()
     }
    );
  }
}
