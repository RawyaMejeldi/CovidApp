import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/widget/drawer.dart';
class Information extends StatelessWidget {
  static const pageRoute="./info";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              drawer: MyDrawer(),

     appBar:AppBar (title:Text('Information '))
    );
  }
}