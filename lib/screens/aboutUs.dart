import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/widget/drawer.dart';

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
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    color: Colors.grey),
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
        ],
      ),
    );
  }
}
