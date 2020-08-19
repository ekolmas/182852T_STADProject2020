import 'package:flutter/material.dart';

// ignore: camel_case_types
class Clinic_Ratings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Clinic Ratings",
            ),
            
            Icon(Icons.directions_bike)
          ]),
    );
  }
}