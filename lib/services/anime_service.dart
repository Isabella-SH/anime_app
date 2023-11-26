import 'dart:convert';
import 'dart:io';                               //importar .io
import 'package:anime_app/model/anime.dart';
import 'package:anime_app/shared/result.dart';
import 'package:http/http.dart' as http;

class AnimeService{

  //https://api.jikan.moe/v4/top/anime?page=2
  String baseUrl="https://api.jikan.moe/v4/top/anime";
  final String _page = '?page=';

  //devuelve en algun momento una lista
  Future<Result> getAll(int page) async{
    //concatena un dato a la ruta
    http.Response response=await http.get(Uri.parse('$baseUrl$_page$page'));

    //si la respuesta devuelve algo
    if(response.statusCode==HttpStatus.ok){

      //es la respuesta de tod el json
      final jsonResponse=json.decode(response.body);
      //crea una lista llamada maps que recoge tod del json
      final List maps=jsonResponse["data"];
      //cada map es asignado a un objeto usando su metodo de fromJson
      final data = maps.map((e) => Anime.fromJson(e)).toList();

      return Result(  //retorna una respuesta satisfactoria
          success: true,
          data: data,
          message: 'Success'
      );
    }
    print(response.body);                   //MENSAJITO SOBRE QUE DEVOLVIO LA LLAMADA
    return const Result(  //retorna una respuesta no satisfactoria
        success: false,
        data: null,
        message: 'API error'
    );
  }
}

