import 'package:anime_app/model/anime.dart';
import 'package:anime_app/repositories/anime_repository.dart';
import 'package:anime_app/screens/anime_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimePreferences extends StatefulWidget {
  const AnimePreferences({super.key});

  @override
  State<AnimePreferences> createState() => _AnimePreferencesState();
}

class _AnimePreferencesState extends State<AnimePreferences> {

  AnimeRepository? _animeRepository;
  List<Anime>? _animes;

  initialize() async{ // "?? []" -> si es nulo, devuelve un arreglo vacio
    _animes=await _animeRepository?.getAll()??[];
    setState((){
      _animes=_animes;
    });
  }

  @override
  void initState(){
    _animeRepository=AnimeRepository();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _animes?.length ?? 0,
      itemBuilder: ((context, index) {
        final anime = _animes![index];
        return AnimeItem(anime: anime);
      }),
    );
  }
}

