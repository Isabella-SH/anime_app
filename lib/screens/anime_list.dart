import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({super.key});

  @override
  State<AnimeList> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("Esta es la vista de anime_list")
    );
  }
}







