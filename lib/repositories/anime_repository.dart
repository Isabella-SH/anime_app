
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

    //para un get solo llamar a la database y el nombre de que tabla necesito la informacion
    final maps=await db.query(AnimeDatabase().tableName);

    //convierto los maps, que se obtienen de la tabla, a objetos Anime
    //retorno una lista de ello
    return maps.map((map)=> Anime.fromMap(map)).toList();
  }

}
