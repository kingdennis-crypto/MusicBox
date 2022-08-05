import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musicbox/screens/add_playlist.dart';
import 'package:musicbox/components/playlist_card.dart';
import 'package:musicbox/screens/favorite.dart';
import 'package:musicbox/store_controller.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final storeController = Get.put(StoreController());
  final String assetName = 'assets/images/bbburst.svg';
  final Widget svg = SvgPicture.asset(
    'assets/bbburst.svg',
    fit: BoxFit.fitWidth,
    alignment: Alignment.bottomRight,
    clipBehavior: Clip.hardEdge,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playlists"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddPlaylistScreen(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _favoriteCard(),
            _playlistColumn(),
          ],
        ),
      ),
    );
  }

  Widget _favoriteCard() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        clipBehavior: Clip.hardEdge,
        child: AspectRatio(
          aspectRatio: 21 / 9,
          child: Material(
            color: const Color(0xFF06083D),
            borderRadius: BorderRadius.circular(6),
            clipBehavior: Clip.hardEdge,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bbburst.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topLeft,
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteScreen(),
                    ),
                  );
                },
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Favorites",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _playlistColumn() {
    void pressButton() {
      print('HELLO');
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: storeController.playlists.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 0, indent: 130),
      itemBuilder: (context, index) => PlaylistCard(
        name: storeController.playlists[index].name,
      ),
    );
  }
}
