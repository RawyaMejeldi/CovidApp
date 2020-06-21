import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/screens/aboutUs.dart';
import 'package:telesuivi_covid_19/screens/home.dart';
import 'package:telesuivi_covid_19/screens/information.dart';
import 'package:telesuivi_covid_19/screens/yourLocation.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 30),
        color: Theme.of(context).primaryColorLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              color: Colors.white,
              child: Text(
                'your location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(YourLocation.pageRoute);
              },
            ),
            FlatButton(
              color: Colors.white,
              child: Text('Days Left',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Home.pageRoute);
              },
            ),
            FlatButton(
              color: Colors.white,
              child: Text('information abour Covid-19',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(Information.pageRoute);
              },
            ),
            FlatButton(
              color: Colors.white,
              child: Text('About us',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AboutUs.pageRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
