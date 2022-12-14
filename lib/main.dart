// Packages
import 'package:get/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:musicbox/screens/home.dart';
import 'package:musicbox/screens/playlist.dart';

class Music {
  String title;
  String artist;

  Music({required this.title, required this.artist});
}

class Playlist {
  final String name;
  final String description;
  final List<Music> songs;

  Playlist(
      {required this.name, required this.description, required this.songs});

  // void addSong(Music song) {
  //   songs.add(song);
  // }
}

// Color Palette 667
// #F55C44
// #2C51A2
// #2C9B95
// #F6B139
// #FFBBB9

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const PlaylistScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MusicBox - Music Mobile App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 1,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.deepPurple,
          ),
          iconTheme: IconThemeData(color: Colors.deepPurple),
        ),
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.deepPurple,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.music_note_list),
              label: 'Playlist',
            ),
          ],
        ),
      ),
    );
  }
}
