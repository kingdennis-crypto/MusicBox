import 'package:flutter/material.dart';
import 'package:musicbox/home.dart';

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
    return const MaterialApp(
      title: 'MusicBox - Music Mobile App',
      home: HomeScreen(),
    );
  }
}
