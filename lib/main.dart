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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicBox - Music Mobile App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 1,
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomeScreen(),
      // home: PlaylistScreen(),
    );
  }
}
