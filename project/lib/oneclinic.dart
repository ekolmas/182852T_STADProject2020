import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project/clinic.dart';
import 'package:project/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'db/database_provider.dart';

class OneClinicPage extends StatelessWidget {
  final ClinicData data2;

  OneClinicPage({Key key, @required this.data2, ClinicData data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(data2.name)),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
                child: Text(
                  data2.name,
                  style: TextStyle(fontSize: 32.0),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purple,
                    border: Border.all(
                      width: 3.0,
                    )),
                width: 200.0,
                height: 60.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Crowd
                  Container(
                    child: Text(
                      data2.crowd.toString() + "\nPatients",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25.0),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    height: 70.0,
                    width: 100.0,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  //Best time
                  Container(
                    child: Text(
                      "Best Time To Go:\n" + data2.besttime,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25.0),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    height: 70.0,
                    width: 250.0,
                  ),
                ],
              ),

              SizedBox(
                height: 40.0,
              ),
              Container(
                child: Column(children: <Widget>[
                  Text(
                    "Address: " + data2.location,
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    "Email: " + data2.email,
                    style: TextStyle(fontSize: 24),
                  ),
                  
                  Text(
                    "HP1: " +
                        data2.number1.toString() +
                        "\nHP2: " +
                        data2.number2.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                ]),
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(15.0)),
                width: 370,
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                margin: EdgeInsets.only(bottom: 40.0),
              ),

              //Take me there button
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.transparent)),
                onPressed: () {
                  var searchterm = removeWhiteSpace(data2.location);
                  launch("http://maps.google.com/?q=" + searchterm);
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      '                        Take me there                        ',
                      style: TextStyle(fontSize: 20.0),
                    )),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        //Call the clinic function
                        launch("tel://" + data2.number1.toString());
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            '     Call Clinic       ',
                            style: TextStyle(fontSize: 20.0),
                          )),
                    ),
                    SizedBox(
                      width: 26.0,
                    ),
                    //Message Button
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        //Call the clinic function
                        launch("sms:" + data2.number1.toString());
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            '     Message Clinic   ',
                            style: TextStyle(fontSize: 20.0),
                          )),
                    ),
                  ]),
              //Call Button

              //Back Button
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.transparent)),
                onPressed: () {
                  //Go Back
                  Navigator.pop(context);
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      '                                 Back                                 ',
                      style: TextStyle(fontSize: 20.0),
                    )),
              ),
            ],
          ),
        ));
  }
}

String removeWhiteSpace(String text) {
  String result = text.replaceAll(' ', '+');
  return result;
}

