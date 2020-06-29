import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../widget/drawer.dart';

class AboutUs extends StatelessWidget {
  static const pageRoute = "./AboutUs";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('About US')),
      body: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.location_on,
                      size: 20, color: Theme.of(context).accentColor),
                  SizedBox(height: 5),
                  Text(
                    'TELESUIVI COVID-19',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight),
                  ),
                ],
              ),
              Text(
                '#Stay_Home',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 17, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'About us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              "We are Electronics engineering  students: Rawya Mejeldi and Fatma Khedhri. We made this app for you. It aims to help you in this sensitive period. So be helpful and aware.Don't threaten the safety of people around you.Don't spread the virus.",
              minFontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
