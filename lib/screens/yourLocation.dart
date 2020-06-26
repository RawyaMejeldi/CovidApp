import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telesuivi_covid_19/widget/drawer.dart';
import 'package:flutter_map_picker/flutter_map_picker.dart';

class YourLocation extends StatelessWidget {
  static const pageRoute = './your_location';

  Future<AreaPickerResult> showloc(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var location = json.decode(prefs.getString('location'));
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AreaPickerScreen(
                  googlePlacesApiKey: 'AIzaSyD1Qn83-DnCl2DOUuZTbe5MG2u9XjY_fiw',
                  initialPosition: LatLng(location['lat'], location['long']),
                  mainColor: Colors.purple,
                  mapStrings: MapPickerStrings.english(),
                  placeAutoCompleteLanguage: 'fr',
                  // markerAsset: 'assets/images/icon_look_area.png',
                )));
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
          FutureBuilder(
            future: showloc(context),
            builder: (_, t) {
            showloc(context);
          })
        ],
      ),
    );
  }
}
