import 'package:flutter/material.dart';
import 'package:musicbox/types/promo.dart';

class TopEpisode extends StatefulWidget {
  final Promo promo;

  const TopEpisode({Key? key, required this.promo}) : super(key: key);

  @override
  State<TopEpisode> createState() => _TopEpisodeState();
}

class _TopEpisodeState extends State<TopEpisode> {
  String getSubTitle() {
    return "Hello";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Image.network(
                  widget.promo.image,
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.promo.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Text("${widget.promo.audioClip.duration.toString()} min"),
            ],
          ),
        ),
      ),
    );
  }
}
