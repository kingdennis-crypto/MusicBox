// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:musicbox/music_detail.dart';

class TopSong extends StatefulWidget {
  const TopSong(
      {Key? key,
      required this.title,
      required this.artist,
      required this.index})
      : super(key: key);

  final String title;
  final String artist;
  final int index;

  @override
  State<TopSong> createState() => _TopSongState();
}

class _TopSongState extends State<TopSong> {
  Color placeColor = Colors.black;

  var menuItems = <String>['Play', 'Add to waitlist', 'Save'];

  void onSelectMenu(item) {
    switch (item) {
      case 'Play':
        print('Play');
        break;
      case 'Add to waitlist':
        print('Add to waitlist');
        break;
      case 'Save':
        print('Save');
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    switch (widget.index) {
      case 1:
        placeColor = const Color.fromARGB(255, 204, 173, 0);
        break;
      case 2:
        placeColor = const Color(0xFFC0C0C0);
        break;
      case 3:
        placeColor = const Color(0xFFCD7F32);
        break;
      default:
        placeColor = Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => MusicDetailScreen(
              artist: widget.artist,
              title: widget.title,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${widget.index.toString()}",
                      style: TextStyle(color: placeColor),
                    ),
                    SizedBox(
                      width: 230,
                      child: Text(
                        widget.title,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.artist,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            PopupMenuButton(
              onSelected: onSelectMenu,
              itemBuilder: (context) {
                return menuItems.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
