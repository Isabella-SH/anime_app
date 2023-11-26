import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AnimeDatabase{

  final int version=1;
  final String databaseName='animes2.db';       //PLURAL
  final String tableName= 'animes_add';        //PLURAL

  Database? _db;

  //funcion patra la creacion de nuetsra base de datos
  Future<Database> openDb()async{
    //abrir el directorio donde estan las databases y lo uno con el nombre de nuestra base se datos
    _db = await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (database, version){
          String query= 'create table $tableName (malId integer primary key, images text, title text, episodes integer, members integer, year integer)';
          log(query);
          database.execute(query);
        }, version: version
    );
    return _db as Database;
  }
}
