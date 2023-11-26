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
    return Scaffold(
      body: ListView.builder(
          itemCount: _animes?.length ?? 0,
          itemBuilder: ((context, index) {
            final anime = _animes![index];
            return AnimeItem(anime: anime);
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          int totalEpisodes = 0;
          int totalMembers = 0;

          _animes?.forEach((anime) {
            totalEpisodes += anime.episodes ?? 0;
            totalMembers += anime.members ?? 0;
          });

          showModalBottomSheet(
              context: context,
              builder: (BuildContext context)
              {return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Episodes: $totalEpisodes'),
                    Text('Total Members: $totalMembers'),
                  ],
                ),
              );
              }
          );
        },
      ),
    );
  }
}

