import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicbox/home.dart';
import 'package:musicbox/playlist.dart';

class Music {
  String title;
  String artist;

  Music({required this.title, required this.artist});
}

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
  List<Widget> _pages = [HomeScreen(), PlaylistScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
