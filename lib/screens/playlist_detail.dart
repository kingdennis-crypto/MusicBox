import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:musicbox/main.dart';
import 'package:musicbox/store_controller.dart';

class PlaylistDetailScreen extends StatefulWidget {
  const PlaylistDetailScreen({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  final storeController = Get.put(StoreController());

  late Playlist playlist;
  late List<Music> songs;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    playlist = storeController.playlists
        .singleWhere((element) => element.name == widget.name);
  }

  void _openInfo() {
    Get.defaultDialog(
      radius: 6,
      contentPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.only(top: 20),
      title: playlist.name,
      middleText: playlist.description,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.name),
        actions: [
          IconButton(
            onPressed: _openInfo,
            icon: const Icon(Icons.info_outline),
            splashRadius: 25,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            icon: Icon(_isEditing ? Icons.edit_off : Icons.edit),
            splashRadius: 25,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            playlist.songs.isEmpty ? _emptyPlaylist() : _filledPlaylist(),
          ],
        ),
      ),
    );
  }

  Widget _filledPlaylist() {
    return ReorderableListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        for (int index = 0; index < playlist.songs.length; index++)
          _number(playlist.songs[index], index),
      ],
      onReorder: (oldIndex, newIndex) {
        setState(() {
          storeController.reorderSongsInPlaylist(
            widget.name,
            oldIndex,
            newIndex,
          );
        });
      },
    );
  }

  Widget _emptyPlaylist() {
    return Container(
      padding: const EdgeInsets.only(top: 140),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/empty_playlist.svg',
              width: MediaQuery.of(context).size.width - 130,
            ),
            const SizedBox(height: 20),
            const Text(
              'You have no songs yet.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Please add songs to this playlist',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _number(Music song, int index) {
    bool _isFavorite = storeController.favoriteSongs
        .where((element) => element.title == song.title)
        .isNotEmpty;

    final List<String> menuItems = [
      'Add to playlist',
      'Share',
      _isFavorite ? 'Remove favorite' : 'Add favorite',
    ];

    void onSelectMenu(item) {
      switch (item) {
        case 'Add to playlist':
          print('Add to playlist');
          break;
        case 'Share':
          print('Share');
          break;
      }
    }

    return Container(
      key: ValueKey(index),
      child: Row(
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(8),
            child: const Card(
              color: Colors.blue,
              elevation: 2,
            ),
          ),
          Text(song.title),
          const Expanded(child: SizedBox()),
          _isEditing
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(CupertinoIcons.line_horizontal_3),
                  ),
                )
              : PopupMenuButton(
                  onSelected: onSelectMenu,
                  icon: const Icon(Icons.more_vert),
                  splashRadius: 25,
                  itemBuilder: (context) {
                    return menuItems.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
        ],
      ),
    );
  }
}
