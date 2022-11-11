import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart';
import 'package:musicbox/components/home/categoryCard.dart';
import 'package:musicbox/components/home/promoCard.dart';
import 'package:musicbox/components/home/topEpisode.dart';
import 'package:musicbox/types/category.dart';
import 'package:musicbox/types/promo.dart';
import 'package:musicbox/types/searchHint.dart';

// TODO: Design - https://dribbble.com/shots/19306769-Podcast-App-Mobile-Design

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  List<Promo> promos = [];
  List<SearchHint> searchHints = [];

  Future fetchData() async {
    const String baseUrl = "https://api.audioboom.com";

    final fetchedData = await get(Uri.parse("$baseUrl/regions/current"));

    categories.clear();
    promos.clear();
    searchHints.clear();

    if (fetchedData.statusCode == 200) {
      var body = json.decode(fetchedData.body)['body'];

      for (var categoryIterate in body['categories']) {
        categories.add(Category.fromJson(categoryIterate));
      }

      for (var promo in body['promos']) {
        promos.add(Promo.fromJson(promo));
      }

      for (var searchHint in body['search_hints']) {
        searchHints.add(SearchHint.fromJson(searchHint));
      }

      return categories;
    } else {
      throw "Unable to retrieve categories";
    }
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: const Color(0xFF36375A),
          )
        ],
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 140),
          child: OverflowBox(
            maxWidth: 240,
            child: Row(
              children: const [
                Icon(
                  CupertinoIcons.cube_box,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 4),
                Text(
                  "MusicBox",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  sectionTitle('Categories'),
                  categoriesScroll(),
                  sectionTitle('Recommended Podcasts'),
                  recommendedListens(),
                  sectionTitle('Top Listens'),
                  topEpisodes(),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget categoriesScroll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(child: CategoryCard(category: categories[0])),
                  Expanded(child: CategoryCard(category: categories[1])),
                  Expanded(child: CategoryCard(category: categories[2])),
                  Expanded(child: CategoryCard(category: categories[3])),
                  Expanded(child: CategoryCard(category: categories[4])),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget recommendedListens() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Row(
          children: List.generate(
            searchHints.length,
            (index) => PromoCard(searchHint: searchHints[index]),
          ),
        ),
      ),
    );
  }

  Widget topEpisodes() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: promos.length,
      itemBuilder: (context, index) => TopEpisode(promo: promos[index]),
    );
  }
}
