import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/widget/drawer.dart';

class Information extends StatelessWidget {
  static const pageRoute = "./info";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Information ')),
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
                    height: 70,
                    width: 70,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'information about \n corona virus',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "COVID-19 is an infectious disease caused by a newly \ndiscovered coronavirus. It affects different people in \ndifferent ways. Most infected people will develop mild \nto moderate symptoms.\nCommon symptoms: Fever, tiredness, dry cough.\nSome people may experience: Aches and pains, nasal\n congestion, runny nose, sore throat, diarrhoea.\nOn average it takes 5–6 days from when someone is infected with the virus for symptoms to show,\n however it can take up to 14 days.People with mild symptoms who are otherwise healthy should self-isolate.",
            style: TextStyle(
                color: Colors.yellow[700],
                fontSize: 15,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
              "Standard recommendations to prevent the spread of COVID-19 include frequent cleaning of hands using alcohol-based hand rub or soap and water; covering the nose and mouth with a flexed elbow or disposable tissue when coughing and sneezing; and avoiding close contact with anyone that has a fever and cough .\nTo date, there are no specific vaccines or medicines for COVID-19. Treatments are under investigation, and will be tested through clinical trials.",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              textAlign: TextAlign.center),
          SizedBox(height: 100),
          Text(
              "To date, there are no specific vaccines or medicines for COVID-19. Treatments are under investigation, and will be tested through clinical trials.",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
