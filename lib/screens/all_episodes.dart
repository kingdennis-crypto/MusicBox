import 'package:flutter/material.dart';
import 'package:musicbox/components/channelDetail/episode.dart';
import 'package:musicbox/types/audioClip.dart';

class AllEpisodesScreen extends StatefulWidget {
  final List<AudioClip> episodeList;
  final String cover;
  final String title;

  const AllEpisodesScreen(
      {Key? key,
      required this.episodeList,
      required this.cover,
      required this.title})
      : super(key: key);

  @override
  State<AllEpisodesScreen> createState() => _AllEpisodesScreenState();
}

class _AllEpisodesScreenState extends State<AllEpisodesScreen> {
  // List<int> months = [];

  // void sortMonths() async {
  //   for (var episode in widget.episodeList) {
  //     int month = episode.uploadedAt.month;
  //     if (!months.contains(month)) months.add(month);
  //   }
  // }

  // @override
  // void initState() {
  //   sortMonths();

  //   super.initState();
  // }

  // TODO - Add header per month
  // TODO - Add refreshindicator

  // onRefresh: () {
  //   SnackBar snackBar = const SnackBar(
  //     content: Text("Succesfully updated the list"),
  //   );

  //   return Future.delayed(
  //     const Duration(seconds: 1),
  //     () {
  //       // TODO - Call function to retrieve podcast data

  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     },
  //   );
  // },

  // RefreshIndicator
  // ScrollBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: LayoutBuilder(
                builder: (context, constraints) => Text(
                  widget.title,
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: constraints.maxHeight < 100
                          ? Colors.deepPurple
                          : Colors.white),
                ),
              ),
              background: Image.network(
                widget.cover,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Episode(audioClip: widget.episodeList[index]),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
