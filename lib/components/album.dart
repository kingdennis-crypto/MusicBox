import 'package:flutter/material.dart';
import 'package:musicbox/music_detail.dart';

class Album extends StatefulWidget {
  const Album({Key? key, required this.albumName, required this.artistName})
      : super(key: key);

  final String albumName;
  final String artistName;

  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  double _size = 1;

  void shrinkCard() {
    setState(() {
      _size = 0.95;
    });
  }

  void inflateCard() {
    setState(() {
      _size = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => shrinkCard(),
      onTapUp: (details) => inflateCard(),
      onTapCancel: () => inflateCard(),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => MusicDetailScreen(
              artist: widget.artistName,
              title: widget.albumName,
            ),
          ),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: IgnorePointer(
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(maxWidth: 150),
          child: Transform.scale(
            alignment: Alignment.topCenter,
            scale: _size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 150,
                  child: Text(
                    widget.albumName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  widget.artistName,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w300,
                  ),
                  // softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
