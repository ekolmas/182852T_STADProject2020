import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/db/database_provider.dart';

import '../main.dart';

// ignore: camel_case_types
class Clinic_HomePage extends StatelessWidget {
  
  final ClinicData data2;

  const Clinic_HomePage({Key key, this.data2}): super(key:key);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "LOG THE CROWD HERE",
            ),

            new RaisedButton(
              child: Text('+'),
              onPressed: (){
                DatabaseProvider.db.plusOneCrowd(data2.id);
                //TODO increase counter
                
              },
            ),

            new RaisedButton(
              child: Text('-'),
              onPressed: (){
                DatabaseProvider.db.minusOneCrowd(data2.id);
                //TODO UPDATE THE CROWD BY 1
              },
            ),
            
          ]),
    );
  }
}