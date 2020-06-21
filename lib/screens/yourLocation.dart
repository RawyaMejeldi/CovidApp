import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/widget/drawer.dart';
class YourLocation extends StatelessWidget {
  static const pageRoute='./your_location';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              drawer: MyDrawer(),

      appBar: AppBar(
        title:Text('Your Location')
      ),
    );
  }
}