import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        child: Column(
          children: <Widget>[
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  Text(storeController.favoriteSongs[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: storeController.favoriteSongs.length,
            )
          ],
        ),
      ),
    );
  }
}
