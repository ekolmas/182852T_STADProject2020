import 'package:flutter/material.dart';
import 'package:project/clinic.dart';
import 'package:project/db/database_provider.dart';
import 'package:project/main.dart';

class Profile extends StatelessWidget {
  final UserData data;

  Profile({Key key,@required this.data}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: data.name);
    final emailController = TextEditingController(text: data.email);
    final numberController = TextEditingController(text: data.number.toString());
    final allergyController = TextEditingController(text: data.allergy);

    // TODO: implement build
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Name:'),
                  TextFormField(controller: nameController,),
                  Text('Email:'),
                  TextFormField(controller: emailController,),
                  Text('Contact Number:'),
                  TextFormField(controller: numberController,),
                  Text('Allergy:'),
                  TextFormField(controller: allergyController,),
                  RaisedButton(onPressed: (){
                    DatabaseProvider.db.UpdateUser(nameController.text,emailController.text,numberController.text,allergyController.text,data.id);
                    Navigator.pop(context);
                  },
                  child: Text("Update Profile"),),
                  RaisedButton(onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Back"),)
                  ]
                  )
                  )
                  );
  }
}
