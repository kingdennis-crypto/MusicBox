import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:musicbox/main.dart';
import 'package:musicbox/components/top_song.dart';

import 'components/album.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Music> forYou = [
    Music(title: "Enemy (ft. JID)", artist: "Image Dragons, JID"),
    Music(title: "Arcade", artist: "Duncan Laurence"),
    Music(title: "Heat Waves", artist: "Glass Animals"),
    Music(title: "This Is My World (feat. Austin Jenckes", artist: "Esterly"),
    Music(title: "I'm Not Famous", artist: "AJR"),
  ];

  List<Music> newReleases = [
    Music(title: "Chant", artist: "Mzcklemore & Tones And I"),
    Music(title: "12345", artist: "Em Beihold"),
    Music(title: "Happier Than Ever", artist: "Kelly Clarkson"),
    Music(title: "I Want It All", artist: "The Script"),
    Music(title: "Human (Deluxe)", artist: "One Republic"),
  ];

  List<Music> topSongs = [];

  Future fetchAlbum() async {
    const String url =
        "http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=02216cd94805c846c6cc6dc3b46fd1aa&format=json";
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)['tracks']['track'];

      for (var singleAlbum in responseData) {
        Music music = Music(
          title: singleAlbum['name'],
          artist: singleAlbum['artist']['name'],
        );

        topSongs.add(music);
      }

      return topSongs;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  @override
  void initState() {
    super.initState();

    fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            // icon: const Icon(CupertinoIcons.gear),
            icon: const Icon(Icons.settings),
            color: const Color(0xFF36375A),
          )
        ],
        leadingWidth: 150,
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 1,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              CupertinoIcons.music_albums_fill,
              color: Color(0xFF9D5DAA),
            ),
            Text(
              "MusicBox",
              style: TextStyle(
                  color: Color(0xFF9D5DAA),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: fetchAlbum(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  children: [
                    _albumRow("Just for you", forYou),
                    _albumRow("New releases", newReleases),
                    _topSongColumn(topSongs),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _albumRow(String title, List<Music> musicList) {
    final random = Random();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Album(
              albumName: musicList[random.nextInt(musicList.length)].title,
              artistName: musicList[random.nextInt(musicList.length)].artist,
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: musicList.length,
          ),
        ),
      ],
    );
  }

  Widget _topSongColumn(List<Music> musicList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Top songs of 2021",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => TopSong(
            title: musicList[index].title,
            artist: musicList[index].artist,
            index: index + 1,
          ),
          // separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: 50,
        )
      ],
    );
  }
}
