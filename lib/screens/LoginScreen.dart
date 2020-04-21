import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/widget/loginClipper.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              blurRadius: 10,
              offset:Offset(10,0),
              color: Colors.black38
            )],
          color: Theme.of(context).accentColor,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ClipPath(
            clipper: LightClipper(),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: DarkClipper(),
            child: Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 30),
                  Icon(Icons.location_on,
                      size: 70, color: Theme.of(context).accentColor),
                  SizedBox(height: 20),
                  Text(
                    'TELESUIVI COVID-19',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 36,
                        color: Theme.of(context).primaryColorLight),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Minister of Public Health\n#Stay_Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        color: Theme.of(context).accentColor),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 50.0, right: 50, bottom: 55),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      splashColor: Colors.grey,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 20,
                                  offset: Offset(10, 10))
                            ]),
                        child: Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 36,
                              color: Theme.of(context).primaryColorLight),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      splashColor: Colors.grey,
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 20,
                                  offset: Offset(10, 10))
                            ]),
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 36,
                              letterSpacing: 1.2,
                              color: Theme.of(context).primaryColorLight),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container()
      ],
    ));
  }
}
