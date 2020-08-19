import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../user.dart';
import '../clinic.dart';

class DatabaseProvider {
  static const String TABLE_USER = "user";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_EMAIL = "email";
  static const String COLUMN_NUMBER = "number";
  static const String COLUMN_ALLERGY = "allergy";
  static const String COLUMN_PASSWORD = "password";

  //Clinic Table
  static const String TABLE_CLINIC = "clinic";
  static const String CLINIC_ID = "id";
  static const String CLINIC_EMAIL = "email";
  static const String CLINIC_NAME = "name";
  static const String CLINIC_LOCATION = "location";
  static const String CLINIC_CROWD = "crowd";
  static const String CLINIC_NUMBER1 = "number1";
  static const String CLINIC_NUMBER2 = "number2";
  static const String CLINIC_BESTTIME = "besttime";
  static const String CLINIC_PASSWORD = "password";

  //Favourite Table
  static const String TABLE_FAVOURITE = "favourite";
  static const String FAVOURITE_ID = "id";
  static const String FAVOURITE_CLINICID = "clinicid";
  static const String FAVOURITE_USERID = "userid";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("Database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, 'userDB.db'), version: 1,
        onCreate: (Database database, int version) async {
      print("Create user table");

//have to match getter
      await database.execute(
        "CREATE TABLE $TABLE_USER ("
        "$COLUMN_ID INTEGER PRIMARY KEY NOT NULL,"
        "$COLUMN_NAME TEXT NOT NULL,"
        "$COLUMN_EMAIL TEXT NOT NULL,"
        "$COLUMN_NUMBER INTEGER NOT NULL,"
        "$COLUMN_ALLERGY TEXT,"
        "$COLUMN_PASSWORD TEXT NOT NULL"
        ")",
      );

print('Creating clinic Table');
      await database.execute(
        "CREATE TABLE $TABLE_CLINIC ("
        "$CLINIC_ID INTEGER PRIMARY KEY NOT NULL,"
        "$CLINIC_EMAIL TEXT NOT NULL,"
        "$CLINIC_NAME TEXT NOT NULL,"
        "$CLINIC_LOCATION TEXT NOT NULL,"
        "$CLINIC_CROWD INTEGER NOT NULL,"
        "$CLINIC_NUMBER1 INTEGER NOT NULL,"
        "$CLINIC_NUMBER2 INTEGER,"
        "$CLINIC_BESTTIME TEXT NOT NULL,"
        "$CLINIC_PASSWORD TEXT NOT NULL"
        ")",
      );

      print("Creating favourites table");
      await database.execute(
        "CREATE TABLE $TABLE_FAVOURITE ("
        "$FAVOURITE_ID INTEGER PRIMARY KEY NOT NULL,"
        "$FAVOURITE_CLINICID INTEGER NOT NULL,"
        "$FAVOURITE_USERID INTEGER NOT NULL,"
        ")",
      );
    });
  }

  Future<User> insert(User user) async {
    final db = await database;
    print("Inserting user");
    user.id = await db.insert(TABLE_USER, user.toMap());

    return user;
  }

  Future<Clinic> clinicInsert(Clinic clinic)async{
    final db=await database;
    print('Inserting Clinic');
    clinic.id = await db.insert(TABLE_CLINIC, clinic.toMap());
  
    return clinic;
  }

  Future<List<Clinic>> clinicLogin(email,password) async{
    final db = await database;
    var result = await db.rawQuery(
      "SELECT * FROM clinic WHERE email='$email' AND password='$password'"
    );

    List<Clinic> clinicList = List<Clinic>();

    result.forEach((currentClinic){
      Clinic clinic = Clinic.fromMap(currentClinic);

      clinicList.add(clinic);
    }); 

     if (result == null) {
      return null;
    } else {
      return clinicList;
    }
  }

  Future<List<User>> getUser(email, password) async {
    final db = await database;
    var result = await db.rawQuery(
        'SELECT * FROM user WHERE email="$email" AND password="$password"');

    List<User> userList = List<User>();

    result.forEach((currentUser) {
      User user = User.fromMap(currentUser);

      userList.add(user);
    });

    if (result == null) {
      return null;
    } else {
      return userList;
    }
  }

  Future<List<Clinic>> getFavourites(userid) async{
    final db=await database;
    var result = await db.rawQuery("SELECT * FROM $TABLE_CLINIC INNER JOIN $TABLE_FAVOURITE ON $TABLE_FAVOURITE.$FAVOURITE_CLINICID = $TABLE_CLINIC.$CLINIC_ID WHERE $FAVOURITE_USERID = $userid");
  
    List<Clinic> clinicList = List<Clinic>();
    result.forEach((currentClinic){
      Clinic clinic = Clinic.fromMap(currentClinic);

      clinicList.add(clinic);
    });
    
  }

  Future<List<Clinic>> getClinic() async{
    final db=await database;
    var result = await db.rawQuery('SELECT * FROM $TABLE_CLINIC');

    List<Clinic> clinicList = List<Clinic>();

    result.forEach((currentClinic){
      Clinic clinic = Clinic.fromMap(currentClinic);

      clinicList.add(clinic);
    });

    return clinicList;
  }

  Future<bool> plusOneCrowd(id) async{
    final db = await database;
    var update = await db.rawUpdate('UPDATE clinic SET $CLINIC_CROWD = $CLINIC_CROWD+1 WHERE id=$id');
    print("plus one");
    return true;
  }

  Future<bool> minusOneCrowd(id) async{
    final db = await database;
    var update = await db.rawUpdate('UPDATE $TABLE_CLINIC SET $CLINIC_CROWD = $CLINIC_CROWD-1 WHERE $CLINIC_ID=$id');

    print("minus one");
    return true;
  }

  Future<String> getCrowd(id) async{
    final db = await database;
    var query = await db.rawQuery('GET * FROM $TABLE_CLINIC WHERE $CLINIC_ID = $id');

    return query.toString();
  }

  Future<void> UpdateUser(name,email,number,allergy,id) async{
    final db = await database;
    var query = await db.rawUpdate('UPDATE $TABLE_USER SET $COLUMN_NAME = "$name", $COLUMN_EMAIL = "$email", $COLUMN_NUMBER = $number, $COLUMN_ALLERGY="$allergy" WHERE $COLUMN_ID=$id');
  }
  


Future<List<Clinic>> getRecommendation() async{
  final db = await database;
  var crowd = await db.rawQuery("SELECT * FROM $TABLE_CLINIC ORDER BY $CLINIC_CROWD asc");


     List<Clinic> clinicList = List<Clinic>();

    Clinic clinic = Clinic.fromMap(crowd[0]);
    Clinic clinic1 = Clinic.fromMap(crowd[1]);
    Clinic clinic2 = Clinic.fromMap(crowd[2]);
    Clinic clinic3 = Clinic.fromMap(crowd[3]);

    clinicList.add(clinic);
    clinicList.add(clinic1);
    clinicList.add(clinic2);
    clinicList.add(clinic3);

    return clinicList;

}

}
