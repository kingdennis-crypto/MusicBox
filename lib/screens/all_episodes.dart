import 'package:flutter/material.dart';
import 'package:musicbox/components/channelDetail/episode.dart';
import 'package:musicbox/types/audioClip.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AllEpisodesScreen extends StatefulWidget {
  final List<AudioClip> episodeList;

  const AllEpisodesScreen({Key? key, required this.episodeList})
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Episodes"),
      ),
      body: RefreshIndicator(
        child: Scrollbar(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: widget.episodeList.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) =>
                Episode(audioClip: widget.episodeList[index]),
          ),
        ),
        onRefresh: () {
          SnackBar snackBar = const SnackBar(
            content: Text("Succesfully updated the list"),
          );

          return Future.delayed(
            const Duration(seconds: 1),
            () {
              // TODO - Call function to retrieve podcast data

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          );
        },
      ),
    );
  }
}
