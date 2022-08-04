import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicbox/main.dart';

class StoreController extends GetxController {
  final isPlaying = false.obs;
  final favoriteSongs = <Music>[].obs;
  final playlists = <Playlist>[
    Playlist(name: 'Playlist 1', description: 'Playlist 1'),
    Playlist(name: 'Playlist 2', description: 'Playlist 2'),
    Playlist(name: 'Playlist 3', description: 'Playlist 3'),
  ].obs;

  final storeNameEditingController = TextEditingController();

  updateIsPlaying(bool status) {
    isPlaying(status);
  }

  addFavoriteSong(String name, String artist) {
    final Music item = Music(title: name, artist: artist);

    favoriteSongs.add(item);
  }

  removeFavoriteSong(String name, String artist) {
    favoriteSongs.removeAt(favoriteSongs.indexWhere(
        (element) => element.title == name && element.artist == artist));
  }

  sortSongsAZ() {
    favoriteSongs.sort((a, b) {
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });
  }

  sortSongsZA() {
    favoriteSongs.sort((a, b) {
      return b.title.toLowerCase().compareTo(a.title.toLowerCase());
    });
  }

  addPlaylist(String name, String description) {
    playlists.add(Playlist(name: name, description: description));
  }

  removePlaylist(String name, String description) {
    playlists.removeAt(playlists.indexWhere((element) =>
        element.name == name && element.description == description));
  }
}
