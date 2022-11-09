import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicbox/types/audioClip.dart';
import 'package:intl/intl.dart';

class Episode extends StatefulWidget {
  final AudioClip audioClip;

  const Episode({Key? key, required this.audioClip}) : super(key: key);

  @override
  State<Episode> createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('yyyy-MM-dd - kk:mm').format(
                  widget.audioClip.uploadedAt,
                ),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Text(
                widget.audioClip.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.audioClip.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    CupertinoIcons.play_circle_fill,
                    size: 20,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    widget.audioClip.getDurationString(),
                    style: const TextStyle(color: Colors.deepPurple),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
