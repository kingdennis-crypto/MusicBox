import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  final isPlaying = false.obs;
  final favoriteSongs = <String>['Song 1', 'Song 2'].obs;

  final storeNameEditingController = TextEditingController();

  updateIsPlaying(bool status) {
    isPlaying(status);
  }

  addFavoriteSong(String name) {
    favoriteSongs.add(name);
  }

  removeFavoriteSong(String name) {
    favoriteSongs.remove(name);
  }
}
