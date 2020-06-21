import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/widget/drawer.dart';

import '../helpers/getColor.dart';
import '../widget/leftDuration.Dart';
import 'aboutUs.dart';
import 'information.dart';
import 'yourLocation.dart';

class Home extends StatelessWidget {
  static const pageRoute = './Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        // drawer: Drawer(
        //   child: Container(
        //     padding: EdgeInsets.only(top: 30),
        //     color: Theme.of(context).primaryColorLight,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: <Widget>[
        //         FlatButton(
        //           color: Colors.white,
        //           child: Text(
        //             'your location',
        //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        //           ),
        //           onPressed: () {
        //             Navigator.of(context)
        //                 .pushReplacementNamed(YourLocation.pageRoute);
        //           },
        //         ),
        //         FlatButton(
        //           color: Colors.white,
        //           child: Text('Days Left',
        //               style:
        //                   TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        //           onPressed: () {
        //             Navigator.of(context).pushReplacementNamed(Home.pageRoute);
        //           },
        //         ),
        //         FlatButton(
        //           color: Colors.white,
        //           child: Text('information abour Covid-19',
        //               style:
        //                   TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        //           onPressed: () {
        //             Navigator.of(context)
        //                 .pushReplacementNamed(Information.pageRoute);
        //           },
        //         ),
        //         FlatButton(
        //           color: Colors.white,
        //           child: Text('About us',
        //               style:
        //                   TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        //           onPressed: () {
        //             Navigator.of(context)
        //                 .pushReplacementNamed(AboutUs.pageRoute);
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        appBar: AppBar(title: Text('#Stay at home')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 40,
                  color: Theme.of(context).accentColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'TELESUIVI COVID-19',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          height: 2,
                          fontWeight: FontWeight.w200,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    Text('#Stay_At_Home!')
                  ],
                ),
              ],
            ),
            Text(
              'Days Left',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              height: 300,
              width: double.infinity,
              child: CustomPaint(
                child: Center(
                    child: Text(
                  '10 days left',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 1.2),
                )),
                foregroundPainter: LeftDuration(
                    bgColor: Colors.grey[200],
                    lineColor: getColor(context, 0.8),
                    percent: 0.8,
                    width: 15.0),
              ),
            )
          ],
        ));
  }
}
