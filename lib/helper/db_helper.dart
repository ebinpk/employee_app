import 'dart:convert';
import 'dart:io';
import 'package:employee_app/datamodel/company_db_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static const _databaseName = "employeedetails.db";
  static const _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
   static Database? _database;


  Future<Database?> get database async {
    if (_database != null) return _database;
    // Instantiate db the first time it is accessed
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
              CREATE TABLE Company (
                nEmployeeId INTEGER,
                cName TEXT  NULL,
                cCatchPhrase TEXT  NULL,
                cBs TEXT  NULL
                
              )
              ''');
    await db.execute('''
              CREATE TABLE GeoLocation (
                nEmployeeId INTEGER,
                lat TEXT  NULL,
                lng TEXT  NULL
                
              )
              ''');

    await db.execute('''
              CREATE TABLE Address (
                nEmployeeId INTEGER ,
                street TEXT  NULL,
                suite TEXT  NULL,
                city TEXT  NULL,
                zipcode TEXT  NULL
                
              )
              ''');
    await db.execute('''
              CREATE TABLE EmployeeHdr (
                nEmployeeId INTEGER PRIMARY KEY,
                name TEXT  NULL,
                username TEXT  NULL,
                email TEXT  NULL,
                phone TEXT  NULL,
                profileImage TEXT  NULL,
                website TEXT  NULL
                
              )
              ''');
  }


  Future<int> employeeHdrInsert(EmployeeHdrModel employeeHdr) async {
    Database? db = await database;
    int id = await db!.insert('EmployeeHdr', employeeHdr.toMap());
    return id;
  }

  Future<int> companyInsert(CompanyModel companyModel) async {
    Database? db = await database;
    int id = await db!.insert('Company', companyModel.toMap());
    return id;
  }

  Future<int> AddressInsert(AddressModel addressModel) async {
    Database? db = await database;
    int id = await db!.insert('Address', addressModel.toMap());
    return id;
  }
  Future<int> LocationInsert(GeoLocationModel geoLocationModel) async {
    Database? db = await database;
    int id = await db!.insert('GeoLocation', geoLocationModel.toMap());
    return id;
  }

   Future<List<ListDataModel>>queryGetListData() async {
    Database? db = await database;
    var res = await db!.rawQuery("select A.nEmployeeId,A.name,A.profileImage,B.cName as companyName from EmployeeHdr A LEFT JOIN Company B "
        "ON A.nEmployeeId=B.nEmployeeId Order By A.name");
    List<ListDataModel> list=res.map((data) => ListDataModel.fromMap(data)).toList();
    return list;
  }

  Future<List<ListDataModel>>queryGetSearchedListData(String keyword) async {
    Database? db = await database;
    var res = await db!.rawQuery("select A.nEmployeeId,A.name,A.profileImage,B.cName as companyName from "
        "EmployeeHdr A LEFT JOIN Company B ON A.nEmployeeId=B.nEmployeeId where A.name like '%$keyword%' OR A.email  like '%$keyword%' Order By A.name");
    List<ListDataModel> list=res.map((data) => ListDataModel.fromMap(data)).toList();
    return list;
  }
Future<List<DetailsModel>>queryGetDetails(int nEmployeeId) async {
    Database? db = await database;
    var res = await db!.rawQuery("select  A. name,A.email,A.website,A.username,A.profileImage,ifnull(phone,'') as phone,B.suite,B.street,B.city,B.zipcode,C.cName as companyName,C.cCatchPhrase,C.cBs from EmployeeHdr A  LEFT JOIN  Address B ON   A.nEmployeeId=B.nEmployeeId "
        "LEFT JOIN Company C ON  A.nEmployeeId=C.nEmployeeId where A.nEmployeeId=$nEmployeeId");
    List<DetailsModel> list=res.map((data) => DetailsModel.fromMap(data)).toList();
    return list;
  }

  deleteAll() async {
    final db = await database;
    db?.rawDelete("Delete  from EmployeeHdr");
    db?.rawDelete("Delete  from GeoLocation");
    db?.rawDelete("Delete from Address");
    db?.rawDelete("Delete  from Company");
  }

}