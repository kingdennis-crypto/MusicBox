import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart';

import 'package:musicbox/components/channelDetail/episode.dart';
import 'package:musicbox/screens/all_episodes.dart';
import 'package:musicbox/types/audioClip.dart';
import 'package:musicbox/types/channel.dart';

class ChannelDetailScreen extends StatefulWidget {
  final int channelId;
  final String title;

  const ChannelDetailScreen(
      {Key? key, required this.channelId, required this.title})
      : super(key: key);

  @override
  State<ChannelDetailScreen> createState() => _ChannelDetailScreenState();
}

// TODO - Add a dynamically pinned listheader for the upload time of episodes
// TODO - https://medium.com/geekculture/dynamically-pinned-list-headers-ee5aa23f1db4

class _ChannelDetailScreenState extends State<ChannelDetailScreen> {
  late Channel channel;
  List<AudioClip> audioClips = [];

  Future fetchData() async {
    const String baseUrl = "https://api.audioboom.com";

    final fetchedChannelData =
        await get(Uri.parse("$baseUrl/channels/${widget.channelId}"));
    final fetchedAudioClipsData = await get(
        Uri.parse("$baseUrl/channels/${widget.channelId}/audio_clips"));

    print("$baseUrl/channels/${widget.channelId}/audio_clips");

    if (fetchedChannelData.statusCode == 200 &&
        fetchedAudioClipsData.statusCode == 200) {
      channel = Channel.fromJson(
          jsonDecode(fetchedChannelData.body)['body']['channel']);

      audioClips.clear();

      for (var clip in jsonDecode(fetchedAudioClipsData.body)['body']
          ['audio_clips']) {
        audioClips.add(AudioClip.fromJson(clip));
      }
    }

    audioClips.sort(((a, b) {
      return b.uploadedAt.compareTo(a.uploadedAt);
    }));

    return [channel, audioClips];
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  // FIXME - When I fast reload it will throw an exception:
  //  RangeError (index): Invalid value: Valid value range is empty: {1,2,3,4}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: Image.network(channel.logo),
                      ),
                    ),
                    channelCover(),
                    const Divider(height: 1),
                    audioList(),
                    showAllEpisodes(),
                    channelMetaData(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget channelCover() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            channel.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(channel.description),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(CupertinoIcons.play_arrow_solid,
                          size: 16, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        "Play",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        (Colors.deepPurple[100])!),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(CupertinoIcons.shuffle,
                          size: 16, color: Colors.deepPurple),
                      SizedBox(width: 4),
                      Text(
                        "Shuffle",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget audioList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, indent: 20),
      itemBuilder: (context, index) => Episode(audioClip: audioClips[index]),
    );
  }

  Widget showAllEpisodes() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllEpisodesScreen(
                episodeList: audioClips,
                cover: channel.logo,
                title: widget.title,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                "Show all",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Icon(CupertinoIcons.chevron_forward),
            ],
          ),
        ),
      ),
    );
  }

  Widget channelMetaData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Created at:"),
              Text(channel.getCreatedString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Updated at:"),
              Text(channel.getUpdatedString()),
            ],
          ),
        ],
      ),
    );
  }
}
