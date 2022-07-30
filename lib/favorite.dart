import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musicbox/components/album.dart';
import 'package:musicbox/store_controller.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final storeController = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 20,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: storeController.favoriteSongs.isEmpty
            ? _noFavorites()
            : _favoritesGrid(),
      ),
    );
  }

  Widget _noFavorites() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 140),
          SvgPicture.asset(
            'assets/empty_favorite.svg',
            width: MediaQuery.of(context).size.width - 130,
          ),
          const SizedBox(height: 20),
          const Text(
            "You have no favorites yet.",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            "Please press the heart to have it favored",
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }

  Widget _favoritesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
        ),
        itemCount: storeController.favoriteSongs.length,
        itemBuilder: (context, index) => Album(
          albumName: storeController.favoriteSongs[index],
          artistName: "artistName",
        ),
      ),
    );
  }
}
