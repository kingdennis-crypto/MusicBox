import 'package:flutter/material.dart';
import 'package:musicbox/screens/channel_detail.dart';
import 'package:musicbox/types/promo.dart';
import 'package:musicbox/types/searchHint.dart';

class PromoCard extends StatefulWidget {
  final SearchHint searchHint;

  const PromoCard({Key? key, required this.searchHint}) : super(key: key);

  @override
  State<PromoCard> createState() => _PromoCardState();
}

class _PromoCardState extends State<PromoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChannelDetailScreen(
                  channelId: widget.searchHint.id,
                  title: widget.searchHint.title,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Image.network(
                  widget.searchHint.image,
                  fit: BoxFit.contain,
                  width: 250,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.searchHint.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
