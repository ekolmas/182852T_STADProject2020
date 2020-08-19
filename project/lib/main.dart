import 'package:flutter/material.dart';
import 'package:project/db/database_provider.dart';
import 'package:project/user.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

import 'clinicpage.dart';
import 'homepage.dart';
import 'settingspage.dart';

import 'clinic/clinic_homepage.dart';
import 'clinic/clinic_myclinic.dart';
import 'clinic/clinic_settings.dart';
import 'clinic/clinic_ratings.dart';

class UserData {
  final int id;
  final String name;
  final String email;
  final int number;
  final String allergy;

  UserData(this.id, this.name, this.email, this.number, this.allergy);
}

class ClinicData{
  final int id;
  final String email;
  final String name;
  final String location;
  final int crowd;
  final int number1;
  final int number2;
  final String besttime;
  final String password;

  ClinicData(this.id,this.email,this.name,this.location,this.crowd,this.number1,this.number2,this.besttime,this.password);
}

void main() => runApp(MyApp());

//Runs Widgets
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: LoginPage(title: 'Login'),
    );
  }
}

//Login Page and _LoginPageState are together
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Controller to get fields
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      //BackGround image
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
          //background is transparent for the background
          backgroundColor: Colors.transparent,
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                //Email Address Field
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      //Text Decoration
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                          hintText: "Email Address",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                          //Border
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          //Focused Border
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 3.0),
                            borderRadius: BorderRadius.circular(40.0),
                          )),
                      //Controller to get the field
                      controller: emailController,
                    )),

                //Password Field
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      //Text Decoration
                      decoration: InputDecoration(
                        
                        fillColor: Colors.white,
                        filled: true,
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                          //Border
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 3.0),
                              borderRadius: BorderRadius.circular(20.0)),
                          //Focused Border
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 3.0),
                            borderRadius: BorderRadius.circular(40.0),
                          )),
                      controller: pwController,
                    )),

                //Row with 2 buttons(Register and Login)
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Login button
                      RaisedButton(
                        onPressed: () async {
                          //Check if email is empty
                          if (emailController.text == "") {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Enter Email"),
                                    content: Text(
                                        "Email Field is empty, please enter your email to Log-in, or if you dont have an account you could register for one"),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterPage()));
                                          },
                                          child: Text('Register')),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Okay"))
                                    ],
                                  );
                                });
                          }
                          //Check if password is empty
                          else if (pwController.text == "") {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Enter Password"),
                                    content: Text(
                                        "Password Field is empty, please enter your password to Log-in, or if you dont have an account you could register for one"),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterPage()));
                                          },
                                          child: Text('Register')),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Okay"))
                                    ],
                                  );
                                });
                          } else {
                            var result = DatabaseProvider.db.getUser(
                                emailController.text, pwController.text);

                            if ((await result).length == 0) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Wrong Username or Password"),
                                      content: Text(
                                          "Login details are invalid please try again, if you do not have an account you can register for one"),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterPage()));
                                            },
                                            child: Text('Register')),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Okay"))
                                      ],
                                    );
                                  });
                            } else {
                              final result2 = (await result)[0];
                              UserData data = new UserData(
                                  result2.id,
                                  result2.name,
                                  result2.email,
                                  result2.number,
                                  result2.allergy);

                              Fluttertoast.showToast(
                                  msg: "Welcome Mr." + result2.name,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.purple,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MenuPage(data: data)));
                            }
                          }
                        },
                        child: Text('LOGIN'),
                      ),

                      //Go to Register Button
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text('REGISTER'),
                      ),

                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClinicLoginPage()));
                        },
                        child: Text('Clinic Log-in'),
                      )
                    ]),
              ]))),
    );
  }
}

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();
  final allergyController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();
    allergyController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //Background Image
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            //Name Field
            Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                child: TextField(
                  //Text Decoration
                  decoration: InputDecoration(
                      hintText: "Full Name",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                      //Border
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 3.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      //Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 3.0),
                        borderRadius: BorderRadius.circular(40.0),
                      )),
                  controller: nameController,
                )),

            //Email Field
            Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                child: TextField(
                  //Text Decoration
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                      //Border
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 3.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      //Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 3.0),
                        borderRadius: BorderRadius.circular(40.0),
                      )),
                  controller: emailController,
                )),

            //Phone Number Field
            Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                child: TextField(
                  //Text Decoration
                  decoration: InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                      //Border
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 3.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      //Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 3.0),
                        borderRadius: BorderRadius.circular(40.0),
                      )),
                  controller: numberController,
                )),

            //Allergy Field
            Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                child: TextField(
                  //Text Decoration
                  decoration: InputDecoration(
                      hintText: "Allergies (IF ANY)",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                      //Border
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 3.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      //Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 3.0),
                        borderRadius: BorderRadius.circular(40.0),
                      )),
                  controller: allergyController,
                )),

            //Password Field
            Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                child: TextField(
                  //Text Decoration
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                      //Border
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 3.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      //Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 3.0),
                        borderRadius: BorderRadius.circular(40.0),
                      )),
                  controller: passwordController,
                )),

            //Confirm Password Field
            Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                child: TextField(
                  //Text Decoration
                  decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                      //Border
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 3.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      //Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 3.0),
                        borderRadius: BorderRadius.circular(40.0),
                      )),
                  controller: confirmPasswordController,
                )),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
              //Back to Login Button
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("BACK"),
              ),

              //Register Button
              RaisedButton(
                onPressed: () {
                  if (nameController.text == "" ||
                      emailController.text == "" ||
                      numberController.text == "" ||
                      passwordController.text == "" ||
                      confirmPasswordController.text == "") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Empty Fields"),
                            content:
                                Text("All info is needed except for allergies"),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Okay"))
                            ],
                          );
                        });
                  } else if (isNumeric(numberController.text) == false) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Contact Number Error"),
                            content:
                                Text("Contact Number cannot have alphabets"),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Okay"))
                            ],
                          );
                        });
                  } else if (EmailValidator.validate(emailController.text) ==
                      false) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Email Address Invalid"),
                            content:
                                Text("Please insert a valid Email address"),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Okay"))
                            ],
                          );
                        });
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Passwords dont match"),
                            content:
                                Text("Passwords do not match please try again"),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Okay"))
                            ],
                          );
                        });
                  } else {
                    User user = User(
                        name: nameController.text,
                        email: emailController.text,
                        number: int.parse(numberController.text),
                        allergy: allergyController.text,
                        password: passwordController.text);

                    DatabaseProvider.db.insert(user);
                    Fluttertoast.showToast(
                        msg: "You are Successfully Registered",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.purple,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pop(context);
                  }
                },
                child: Text("REGISTER"),
              )
            ]),

            SizedBox(height: 50.0)
          ],
        )),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  final UserData data;

  MenuPage({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.yellow,
                  ),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(
                    Icons.directions_bike,
                    color: Colors.yellow,
                  ),
                  text: 'Clinics',
                ),
                
                Tab(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.yellow,
                  ),
                  text: 'Settings',
                ),
              ]),
            ),
            body: TabBarView(children: [
              HomePage1(),
              ClinicPage(),
              SettingsPage(data:data),
            ]),
          )),
    );
  }
}

class ClinicLoginPage extends StatefulWidget{
  ClinicLoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClinicLoginState createState() => _ClinicLoginState();
}

class _ClinicLoginState extends State<ClinicLoginPage>{
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      //BackGround image
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
          //background is transparent for the background
          backgroundColor: Colors.transparent,
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      "CLINIC LOG-IN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                //Email Address Field
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      //Text Decoration
                      decoration: InputDecoration(
                        
                        fillColor: Colors.white,
                        filled: true,
                          hintText: "Clinic Email Address",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                          //Border
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          //Focused Border
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 3.0),
                            borderRadius: BorderRadius.circular(40.0),
                          )),
                      //Controller to get the field
                      controller: emailController,
                    )),

                //Password Field
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      //Text Decoration
                      decoration: InputDecoration(
                        
                        fillColor: Colors.white,
                        filled: true,
                          hintText: "Clinic Password",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                          //Border
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 3.0),
                              borderRadius: BorderRadius.circular(20.0)),
                          //Focused Border
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 3.0),
                            borderRadius: BorderRadius.circular(40.0),
                          )),
                      controller: pwController,
                    )),

                //Row with 2 buttons(Register and Login)
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Login button
                      RaisedButton(
                        onPressed: () async {
                          //Check if email is empty
                          if (emailController.text == "") {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Enter Email"),
                                    content: Text(
                                        "Email Field is empty, please enter your email to Log-in, or if you dont have an account you could register for one"),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                           //TODO send to application page
                                          },
                                          child: Text('Apply')),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Okay"))
                                    ],
                                  );
                                });
                          }
                          //Check if password is empty
                          else if (pwController.text == "") {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Enter Password"),
                                    content: Text(
                                        "Password Field is empty, please enter your password to Log-in, or if you dont have an account you could register for one"),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            //TODO: To Application page
                                          },
                                          child: Text('Apply')),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Okay"))
                                    ],
                                  );
                                });
                          } else {
                            var result = DatabaseProvider.db.clinicLogin(
                                emailController.text, pwController.text);

                            if ((await result).length == 0) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Wrong Username or Password"),
                                      content: Text(
                                          "Login details are invalid please try again, if you do not have an account you can register for one"),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              //TODO go to application page
                                            },
                                            child: Text('Apply')),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Okay"))
                                      ],
                                    );
                                  });
                            } else {
                              final result2 = (await result)[0];
                              ClinicData data = new ClinicData(
                                  result2.id,
                                  result2.email,
                                  result2.name,
                                  result2.location,
                                  result2.crowd,
                                  result2.number1,
                                  result2.number2,
                                  result2.besttime,
                                  result2.password,
                                  );

                              Fluttertoast.showToast(
                                  msg: "Welcome " + result2.name,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.purple,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ClinicMenu(data: data)));

                            }
                          }
                        },
                        child: Text('LOGIN'),
                      ),

                      //Go to Register Button
                      RaisedButton(
                        onPressed: () {
                          //TODO SEND TO APPLICATION PAGE
                        },
                        child: Text('APPLY'),
                      ),

                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Client Log-in'),
                      )
                    ]),
              ]))),
    );
}
}

class ClinicMenu extends StatelessWidget{
  final ClinicData data;
  ClinicMenu({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                  ),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(
                    Icons.directions_bike,
                  ),
                  text: 'My Clinic',
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  text: 'My Ratings',
                ),
                Tab(
                  icon: Icon(
                    Icons.settings,
                  ),
                  text: 'Clinic Setting',
                ),
              ]),
            ),
            body: TabBarView(children: [
              Clinic_HomePage(data2: data,),
              Clinic_MyClinic(),
              Clinic_Ratings(),
              Clinic_SettingsPage(),
            ]),
          )),
    );
  }
}
//Other Functions

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
