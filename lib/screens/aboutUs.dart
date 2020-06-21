import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/widget/drawer.dart';

class AboutUs extends StatelessWidget {
  static const pageRoute = "./AboutUs";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('About US')),
    );
  }
}
