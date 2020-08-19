import 'package:flutter/material.dart';

// ignore: camel_case_types
class Clinic_MyClinic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "My Clinic ",
            ),
            
            Icon(Icons.directions_bike)
          ]),
    );
  }
}