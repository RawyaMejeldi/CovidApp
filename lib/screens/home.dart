import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/getColor.dart';
import '../widget/drawer.dart';
import '../widget/leftDuration.Dart';
import '../helpers/loacate.dart';

Future<int> get lefDuration async {
  final prefs = await SharedPreferences.getInstance();
  var start_date_iso = prefs.getString('start_date');
  var start_date = DateTime.parse(start_date_iso);
  var difference = DateTime.now().difference(start_date).inDays;
  var leftDuration = 14 - difference;
  return leftDuration;
}

class Home extends StatelessWidget {
  static const pageRoute = './Home';
  @override
  Widget build(BuildContext context) {
    locate();
    int left;
    lefDuration.then((value) => left = value);
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
              child: FutureBuilder(
                future: lefDuration,
                builder: (_, AsyncSnapshot<int> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final duration = snapshot.data;
                    return CustomPaint(
                      child: Center(
                          child: Text(
                        '${duration.toString()} days left',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            letterSpacing: 1.2),
                      )),
                      foregroundPainter: LeftDuration(
                          bgColor: Colors.grey[200],
                          lineColor: getColor(context, duration / 14),
                          percent: duration / 14,
                          width: 15.0),
                    );
                  }
                },
              ),
            )
          ],
        ));
  }
}
