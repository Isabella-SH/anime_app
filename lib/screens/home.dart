
import 'package:anime_app/screens/anime_list.dart';
import 'package:anime_app/screens/anime_preferences.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedTab=0;

  final List<Widget> _children=[
    const AnimeList(),
    const AnimePreferences()
  ];

  _changeTab(int index){
    setState(() {
      _selectedTab=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animes"),
      ),
      body: _children[_selectedTab],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index)=> _changeTab(index),

        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Total Animes"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Anime Adds"),
        ],
      ),
    );
  }
}


