import 'package:project/db/database_provider.dart';

class Clinic{
  int id;
  String email;
  String name;
  String location;
  int crowd;
  int number1;
  int number2;
  String besttime;
  String password;

  Clinic({
    this.id,
    this.email,
    this.name,
    this.location,
    this.crowd,
    this.number1,
    this.number2,
    this.besttime,
    this.password,
  });

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      DatabaseProvider.CLINIC_EMAIL: email,
      DatabaseProvider.CLINIC_NAME: name,
      DatabaseProvider.CLINIC_LOCATION: location,
      DatabaseProvider.CLINIC_CROWD: crowd,
      DatabaseProvider.CLINIC_NUMBER1: number1,
      DatabaseProvider.CLINIC_NUMBER2: number2,
      DatabaseProvider.CLINIC_BESTTIME: besttime,
      DatabaseProvider.CLINIC_PASSWORD: password,
    };

    if(id!=null){
      map[DatabaseProvider.CLINIC_ID] = id;
    }
    return map;
  }

  Clinic.fromMap(Map<String, dynamic> map){
    id = map[DatabaseProvider.CLINIC_ID];
    email = map[DatabaseProvider.CLINIC_EMAIL];
    name = map[DatabaseProvider.CLINIC_NAME];
    location = map[DatabaseProvider.CLINIC_LOCATION];
    crowd = map[DatabaseProvider.CLINIC_CROWD];
    number1 = map[DatabaseProvider.CLINIC_NUMBER1];
    number2 = map[DatabaseProvider.CLINIC_NUMBER2];
    besttime = map[DatabaseProvider.CLINIC_BESTTIME];
    password = map[DatabaseProvider.CLINIC_PASSWORD];
    
  }
}