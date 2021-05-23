import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableWord='users';
final String cname = 'name';
final String cid = 'id';
final String cenrollNo = 'enrollNo';
final String cstandard = 'standard';
final String cdivision = 'division';
final String cguardianName = 'guardianName';
final String cbloodGroup = 'bloodgroup';
final String cdob = 'dob';
final String cmobileNo = 'mobileNo';
// data model class
class Word {

  String id;
  String name ;
  String enrollNo ;
  String standard ;
  String division ;
  String guardianName ;
  String bloodGroup ;
  String dob ;
  String mobileNo ;

  Word();

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    id=map[cid];
    name = map[cname];
    enrollNo = map[cenrollNo];
    standard = map[cstandard];
    division = map[cdivision];
    guardianName = map[cguardianName];
    bloodGroup = map[cbloodGroup];
    dob = map[cdob];
    mobileNo = map[cmobileNo];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
    cid: id,
      cname: name ,
    cenrollNo: enrollNo,
    cstandard : standard,
    cdivision : division,
    cguardianName : guardianName,
    cbloodGroup : bloodGroup,
    cdob : dob ,
    cmobileNo : mobileNo ,
    };
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    //if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableWord (
                $cid VARCHAR(20) ,
                $cname VARCHAR(100) ,
                $cenrollNo VARCHAR(100) ,
                $cstandard VARCHAR(100) ,
                $cdivision VARCHAR(100) ,
                $cguardianName VARCHAR(100) ,
                $cbloodGroup VARCHAR(10) ,
                $cdob VARCHAR(50),
                $cmobileNo VARCHAR(20)
              )
              ''');
  }

  // Database helper methods:

  Future<void> insert(Word word) async {
    Database db = await database;
    await db.insert(tableWord, word.toMap());
    print("inserted");
  }

  Future<Word> queryWord(String id) async {
    Database db = await database;
    List<Map> maps = await db.query( tableWord,
        columns: [cid,cname,cenrollNo,cstandard,cdivision,cguardianName,cbloodGroup,cdob,cmobileNo],
        where: '$tableWord.$cid = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}