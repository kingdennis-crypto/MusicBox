import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicbox/main.dart';

class StoreController extends GetxController {
  final isPlaying = false.obs;
  final favoriteSongs = <Music>[].obs;
  final playlists = <Playlist>[
    Playlist(name: 'Playlist 1', description: 'Playlist 1 description', songs: [
      Music(title: 'Song 1', artist: 'Artist 1'),
      Music(title: 'Song 2', artist: 'Artist 2')
    ]),
    Playlist(
        name: 'Playlist 2', description: 'Playlist 2 description', songs: []),
    Playlist(
        name: 'Playlist 3', description: 'Playlist 3 description', songs: []),
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
    playlists.add(Playlist(name: name, description: description, songs: []));
  }

  removePlaylist(String name, String description) {
    playlists.removeAt(playlists.indexWhere((element) =>
        element.name == name && element.description == description));
  }

  addSongToPlaylist(Music song, String playlistName) {
    // Get the playlist instance
    Playlist playlist =
        playlists.singleWhere((element) => element.name == playlistName);

    // Add song from parameter to playlist
    playlist.songs.add(song);
  }

  reorderSongsInPlaylist(String playlistName, int oldIndex, int newIndex) {
    Playlist playlist =
        playlists.singleWhere((element) => element.name == playlistName);

    print(playlist);

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final Music item = playlist.songs.removeAt(oldIndex);
    playlist.songs.insert(newIndex, item);
  }
}
