
import 'package:anime_app/database/anime_database.dart';
import 'package:anime_app/model/anime.dart';
import 'package:sqflite/sqflite.dart';

class AnimeRepository{

  //insertar un pokemon
  Future insert(Anime anime) async{
    Database db= await AnimeDatabase().openDb();
    //metodo de pokemon.dart
    db.insert(AnimeDatabase().tableName, anime.toMap());
  }

  Future delete(Anime anime) async{
    Database db= await AnimeDatabase().openDb();
    //metodo de pokemon.dart
    db.delete(AnimeDatabase().tableName,
        where: "malId=?", whereArgs:[anime.malId]);
  }

  //lista pokemons que se marcaron como favorito
  Future<bool> isAdd(Anime anime) async{
    Database db= await AnimeDatabase().openDb();
    //metodo de pokemon.dart
    final maps=await db.query(AnimeDatabase().tableName,
        where: "malId=?", whereArgs: [anime.malId]);

    //maps esta lleno es true, por eso el "isNotEmpty"
    return maps.isNotEmpty;  //devuelve todos los que se guardaron en la tabla
  }

  Future<List<Anime>> getAll() async{

    Database db= await AnimeDatabase().openDb();

    //crea una lista de mapeos, que es el registro de la base de datos de la tabla señalada
    final List<Map<String,dynamic>> maps=await db.query('animes_add');

    //crea una lista, en donde cada index recorrido y asigno datos a un constructo de la clase "Anime"
    return List.generate(maps.length, (i) {
      return Anime(maps[i]['malId'], Images(Jpg(maps[i]['images'])), maps[i]['title'],maps[i]['episodes'],maps[i]['members'],maps[i]['year']);
    });
  }

}
