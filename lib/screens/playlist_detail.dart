import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musicbox/main.dart';
import 'package:musicbox/store_controller.dart';

// TODO Fix the number rearangement without edit toggled one
// TODO Fix the no numbers available illustration (To big)
// TODO Add support for playlist image cover select from local photos
// TODO Add support for editing title and description in edit mode
// TODO When details edited and you exit edit mode, show banner to ask user if he wants to save his changes

// FIXME A dismissed Dismissible widget is still part of the tree.

class PlaylistDetailScreen extends StatefulWidget {
  const PlaylistDetailScreen({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  final storeController = Get.put(StoreController());
  final ImagePicker _imagePicker = ImagePicker();

  String imagePath = "";

  late Playlist playlist;
  late List<Music> songs;
  late File image;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _playlistIllustration(),
            _playlistName(),
            const SizedBox(height: 10),
            const Divider(indent: 10, endIndent: 10),
            playlist.songs.isEmpty ? _emptyPlaylist() : _filledPlaylist(),
          ],
        ),
      ),
    );
  }

  Widget _playlistIllustration() {
    void _selectImage() async {
      // final XFile? _image =
      //     await _imagePicker.pickImage(source: ImageSource.gallery);

      // // FIXME: The image after getting selected does not load.
      // setState(() {
      //   imagePath = _image!.path;
      //   image = _image as File;
      // });

      print('Selecting image');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(6),
                // image: imagePath.isEmpty
                //     ? DecorationImage(image: AssetImage(imagePath))
                //     : null,
              ),
              clipBehavior: Clip.hardEdge,
              child: _isEditing
                  ? Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _selectImage,
                        child: Center(
                          child: Material(
                            color: Colors.white.withOpacity(0.4),
                            shape: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _playlistName() {
    return Column(
      children: <Widget>[
        Text(
          playlist.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Text(playlist.description),
      ],
    );
  }

  Widget _filledPlaylist() {
    return ReorderableListView(
      shrinkWrap: true,
      buildDefaultDragHandles: true,
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
    bool isFavorite = storeController.favoriteSongs
        .where((element) => element.title == song.title)
        .isNotEmpty;

    final List<String> menuItems = [
      'Add to playlist',
      'Share',
      isFavorite ? 'Remove favorite' : 'Add favorite',
    ];

    void onSelectMenu(item) {
      switch (item) {
        // TODO: Add functionality to add to a playlist
        case 'Add to playlist':
          print('Add to playlist');
          break;
        // TODO: Open share sheet
        case 'Share':
          print('Share');
          break;
      }
    }

    return Dismissible(
      key: ValueKey(index),
      background: Container(
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      child: IgnorePointer(
        // ignoring: !_isEditing, // If editing is disabled, disable drag
        ignoring: false,
        key: ValueKey(index),
        child: Container(
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
        ),
      ),
    );
  }
}
