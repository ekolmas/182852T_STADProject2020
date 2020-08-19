import 'package:project/db/database_provider.dart';

class User {
  int id;
  String name;
  String email;
  int number;
  String allergy;
  String password;

  User({
    this.id,
    this.name,
    this.email,
    this.number,
    this.allergy,
    this.password,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_EMAIL: email,
      DatabaseProvider.COLUMN_NUMBER: number,
      DatabaseProvider.COLUMN_ALLERGY: allergy,
      DatabaseProvider.COLUMN_PASSWORD: password,
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    email = map[DatabaseProvider.COLUMN_EMAIL];
    number = map[DatabaseProvider.COLUMN_NUMBER];
    allergy = map[DatabaseProvider.COLUMN_ALLERGY];
    password = map[DatabaseProvider.COLUMN_PASSWORD];
  }
}
