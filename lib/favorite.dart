import 'package:flutter/material.dart';
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
            top: 20, bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          children: [
            Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}
