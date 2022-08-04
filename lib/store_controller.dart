import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicbox/main.dart';

class StoreController extends GetxController {
  final isPlaying = false.obs;
  final favoriteSongs = <Music>[].obs;

  final storeNameEditingController = TextEditingController();

  updateIsPlaying(bool status) {
    isPlaying(status);
  }

  addFavoriteSong(String name, String artist) {
    final Music item = Music(title: name, artist: artist);

    favoriteSongs.add(item);
  }

  removeFavoriteSong(String name, String artist) {
    final Music item = Music(title: name, artist: artist);

    favoriteSongs.remove(item);
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
}
