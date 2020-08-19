import 'package:flutter/material.dart';
import 'package:project/db/database_provider.dart';

import 'clinic.dart';
import 'oneclinic.dart';

class ClinicData {
  final int id;
  final String email;
  final String name;
  final String location;
  final int crowd;
  final int number1;
  final int number2;
  final String besttime;
  final String password;

  ClinicData(this.id, this.email, this.name, this.location, this.crowd,
      this.number1, this.number2, this.besttime, this.password);
}

class HomePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/background.png"),
          fit: BoxFit.cover
        )
      ),
        child: CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Recommendations'),
          ),
          backgroundColor: Colors.purple,
        ),
        SliverToBoxAdapter(
            child: Container(
          alignment: Alignment.center,
          child: Text("Least Crowded"),
        )),
        SliverFixedExtentList(
          itemExtent: 100.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                child: FutureBuilder(
                  future: DatabaseProvider.db.getRecommendation(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none) {
                      return Text('No Data here');
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text('Waiting for Data');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return InkWell(
                        onTap: () {
                          ClinicData data = new ClinicData(
                            snapshot.data[index].id,
                            snapshot.data[index].email,
                            snapshot.data[index].name,
                            snapshot.data[index].location,
                            snapshot.data[index].crowd,
                            snapshot.data[index].number1,
                            snapshot.data[index].number2,
                            snapshot.data[index].besttime,
                            snapshot.data[index].password,
                          );
                          print(snapshot.data[index].email);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OneClinicPage(
                                        data2: data,
                                      )));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 20.0,
                                right: 20.0),
                            alignment: Alignment.center,
                            child: Text(snapshot.data[index].name +
                                " Crowd: " +
                                snapshot.data[index].crowd.toString() +
                                " \nAddress: " +
                                snapshot.data[index].location +
                                snapshot.data[index].id.toString() +
                                "\nContact No: " +
                                snapshot.data[index].number1.toString() +
                                "\nBest Time To Visit: " +
                                snapshot.data[index].besttime)),
                      );
                    }
                  },
                ),
              );
            },
            childCount: 4,
          ),
        ),
        SliverToBoxAdapter(
            child: Container(
          alignment: Alignment.center,
          child: Text("Oldies!"),
        )),
        SliverFixedExtentList(
          itemExtent: 100.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                child: FutureBuilder(
                  future: DatabaseProvider.db.getClinic(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none) {
                      return Text('No Data here');
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text('Waiting for Data');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return InkWell(
                        onTap: () {
                          ClinicData data = new ClinicData(
                            snapshot.data[index].id,
                            snapshot.data[index].email,
                            snapshot.data[index].name,
                            snapshot.data[index].location,
                            snapshot.data[index].crowd,
                            snapshot.data[index].number1,
                            snapshot.data[index].number2,
                            snapshot.data[index].besttime,
                            snapshot.data[index].password,
                          );
                          print(snapshot.data[index].email);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OneClinicPage(
                                        data2: data,
                                      )));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(snapshot.data[index].name +
                              " Crowd: " +
                              snapshot.data[index].crowd.toString() +
                              " \nAddress: " +
                              snapshot.data[index].location +
                              snapshot.data[index].id.toString() +
                              "\nContact No: " +
                              snapshot.data[index].number1.toString() +
                              "\nBest Time To Visit: " +
                              snapshot.data[index].besttime),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                        ),
                      );
                    }
                  },
                ),
              );
            },
            childCount: 4,
          ),
        ),
      ],
    ));
  }
}
