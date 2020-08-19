import 'package:flutter/material.dart';
import 'package:project/about.dart';
import 'package:project/clinic.dart';
import 'package:project/db/database_provider.dart';
import 'package:project/main.dart';
import 'package:project/profile.dart';

import 'help.dart';

class SettingsPage extends StatelessWidget {
  final UserData data;

  SettingsPage({Key key,@required this.data}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Profile
          InkWell(
            onTap: (){
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(data:data)));
            },
              child: Container(
                width: 400,
                decoration: BoxDecoration(color:Colors.grey),
            child: Text('Profile', style: TextStyle(fontSize: 20)),
          )),

          //About
          InkWell(
            onTap: (){
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => About()));
            },
              child: Container(
                width: 400,
                decoration: BoxDecoration(color:Colors.grey),
            child: Text('About', style: TextStyle(fontSize: 20)),
          )),

          //Help
          InkWell(
            onTap: (){
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Help()));
            },
              child: Container(
                width: 400,
                decoration: BoxDecoration(color:Colors.grey),
            child: Text('Help', style: TextStyle(fontSize: 20)),
          )),

          //LogOut
          InkWell(
            onTap: (){
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
            },
              child: Container(
                width: 400,
                decoration: BoxDecoration(color:Colors.grey),
            child: Text('Log Out', style: TextStyle(fontSize: 20)),
          )),
          
          
         
        ]));
  }
}
