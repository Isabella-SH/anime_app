
import 'package:anime_app/screens/anime_list.dart';
import 'package:anime_app/screens/anime_preferences.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimePreferences(),
    );
  }
}
