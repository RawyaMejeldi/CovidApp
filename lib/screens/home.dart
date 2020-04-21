import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/helpers/getColor.dart';
import 'package:telesuivi_covid_19/widget/leftDuration.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('#Stay at home')),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              height: 300,
              width: double.infinity,
              child: CustomPaint(
                child: Center(child: Text('10 days left',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,letterSpacing: 1.2 ),)),
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
