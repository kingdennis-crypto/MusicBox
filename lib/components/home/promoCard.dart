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

class _PromoCardState extends State<PromoCard>
    with SingleTickerProviderStateMixin {
  double scale = 1.0;

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    animation = Tween<double>(
      begin: 1,
      end: 0.95,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        controller.forward();
        // setState(() {
        //   scale = 0.9;
        // });
      },
      onTapUp: (details) {
        controller.reverse();
        // setState(() {
        //   scale = 1.0;
        // });
      },
      onTapCancel: () {
        controller.reverse();
        // setState(() {
        //   scale = 1.0;
        // });
      },
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
      child: Transform.scale(
        scale: animation.value,
        child: Container(
          width: 250,
          margin: const EdgeInsets.only(right: 10),
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
              const SizedBox(height: 3),
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
