import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telesuivi_covid_19/widget/drawer.dart';

class YourLocation extends StatelessWidget {
  static const pageRoute = './your_location';

  Future<GeoCoord> get getcoord async {
    final prefs = await SharedPreferences.getInstance();
    var location = json.decode(prefs.getString('location'));
    return GeoCoord(location['lat'], location['long']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Your Location')),
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
                    'your location',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.5,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 400,
            width: 400,
            child: FutureBuilder(
                future: getcoord,
                builder: (_, t) => t.connectionState == ConnectionState.waiting
                    ? CircularProgressIndicator()
                    : GoogleMap(
                        interactive: false,
                        initialZoom: 18,
                        mapType: MapType.satellite,
                        initialPosition: t.data,
                      )),
          )
        ],
      ),
    );
  }
}
