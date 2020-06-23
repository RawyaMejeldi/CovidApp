import 'package:flutter/material.dart';

import '../helpers/getColor.dart';
import '../widget/drawer.dart';
import '../widget/leftDuration.Dart';
import 'package:hive/hive.dart';

Future<dynamic> get lefDuration async {
  var box = await Hive.box('user');
  var start_date_iso = box.get('start_date');
  // var start_date=DateTime.parse(start_date_iso);
  return (start_date_iso);
}

class Home extends StatelessWidget {
  static const pageRoute = './Home';
  @override
  Widget build(BuildContext context) {
    // var leftDuration=DateTime.now().subtract(Duration(days: star_date));
    print(lefDuration);

    return Scaffold(
        drawer: MyDrawer(),
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
