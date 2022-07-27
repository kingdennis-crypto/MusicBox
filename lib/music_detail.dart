import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class MusicDetailScreen extends StatefulWidget {
  const MusicDetailScreen({Key? key, required this.title, required this.artist})
      : super(key: key);

  final String title;
  final String artist;

  @override
  State<MusicDetailScreen> createState() => _MusicDetailScreenState();
}

class _MusicDetailScreenState extends State<MusicDetailScreen>
    with TickerProviderStateMixin {
  double sliderValue = 10;
  bool _isFavorite = false;
  bool _isPlaying = false;

  bool _isShuffle = false;
  int _repeatStatus = 0;

  void goBack() {
    Navigator.pop(context);
  }

  final PanelController _panelController = PanelController();
  final String _lyrics = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut bibendum arcu. Sed scelerisque pretium tellus, nec consectetur lacus fringilla eu. Proin convallis metus odio, at maximus ante viverra sit amet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et consectetur libero. Aenean tincidunt erat dolor, non semper ipsum fermentum nec. Cras venenatis, odio sed egestas ultrices, ligula ligula placerat leo, ac malesuada orci metus ut quam. In iaculis leo ac quam ultrices, vitae interdum orci suscipit. Vestibulum nibh lorem, eleifend vel nisl et, dapibus suscipit sapien. Suspendisse id metus sed nulla suscipit eleifend. Quisque tincidunt sagittis nibh, eu ornare lectus tincidunt eu. In hac habitasse platea dictumst. Ut iaculis sem non luctus commodo. Aenean justo quam, ultricies et dui eu, congue ultrices arcu. Pellentesque euismod auctor nibh, non faucibus nisi tempus nec. 

    Quisque mattis turpis nisi, in ultricies dolor pellentesque quis. Pellentesque dictum magna sit amet felis maximus porttitor. Curabitur lacinia neque cursus, molestie lorem vel, hendrerit mi. Suspendisse nec arcu nec magna posuere rhoncus. Nullam rhoncus molestie lacus, nec elementum ligula laoreet eu. Phasellus tristique sollicitudin leo non pharetra. Etiam viverra libero vitae tellus rhoncus sodales. Nulla ultrices pharetra porta. 

    Fusce tempus auctor elit, eget tempor tortor interdum ac. Aliquam scelerisque mollis vestibulum. Cras ornare, purus ut venenatis pharetra, enim risus consequat tellus, ut mattis quam tellus ac odio. Etiam eget eros vel mauris iaculis congue at at odio. Cras at lacus consectetur turpis auctor dictum et in turpis. Sed in felis orci. Praesent vitae velit facilisis, auctor urna et, lobortis nibh. Nulla laoreet lacus efficitur, ultricies eros ut, laoreet ex. Pellentesque nibh nisi, dignissim sed risus vestibulum, finibus efficitur nisl. Sed tempus pulvinar tincidunt. Vivamus vitae diam quis est feugiat eleifend ac quis elit. Sed euismod nunc lorem, ac tristique sapien accumsan nec. Donec porttitor eget risus a elementum. Praesent fringilla tincidunt finibus. Aenean consequat finibus lectus ac hendrerit.

    Pellentesque eu ligula iaculis, bibendum ligula quis, efficitur ipsum. Praesent varius ex justo, at tempor quam imperdiet id. Cras ac enim at purus feugiat sollicitudin eget sit amet risus. Ut laoreet orci ut leo condimentum hendrerit. Morbi et luctus metus. Ut ac dui odio. Phasellus suscipit lectus quis malesuada pretium. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; 

    Suspendisse in scelerisque nibh. Morbi maximus ligula vitae arcu ornare rhoncus. Proin scelerisque nunc id lectus efficitur, a mattis eros aliquet. Duis lectus leo, condimentum at leo in, consequat auctor massa. Vestibulum varius laoreet finibus. Nulla blandit tristique suscipit. Pellentesque quis massa ut justo dignissim consectetur non sed libero. Quisque interdum cursus felis, vel fermentum turpis molestie quis. Donec in molestie nisi. Donec facilisis pretium lectus ut consequat. Aliquam tortor ex, pulvinar eu nulla eu, luctus eleifend orci. In id arcu ullamcorper, feugiat ligula non, cursus sem. Cras quis luctus nulla, in molestie nisi. Mauris sed tellus in lectus sagittis convallis et eget elit. Etiam fringilla ultrices pulvinar. Fusce fringilla quis odio nec porttitor. 
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Now playing"),
        leading: IconButton(
          onPressed: goBack,
          splashRadius: 25,
          icon: const Icon(CupertinoIcons.chevron_down),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
            splashRadius: 25,
          )
        ],
        backgroundColor: const Color(0xFFFAFAFA),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SlidingUpPanel(
        controller: _panelController,
        backdropEnabled: true,
        borderRadius: BorderRadius.circular(10),
        maxHeight: MediaQuery.of(context).size.height - 150,
        boxShadow: const [],
        panel: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _panel(),
        ),
        collapsed: GestureDetector(
          onTap: () {
            _panelController.open();
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFA),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  const Icon(CupertinoIcons.chevron_up),
                  const SizedBox(height: 4),
                  Text(
                    "Swipe up for lyrics".toUpperCase(),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedScale(
                scale: _isPlaying ? 1 : 0.75,
                duration: const Duration(milliseconds: 200),
                curve: _isPlaying ? Curves.easeOutCubic : Curves.easeInCubic,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: Colors.deepPurpleAccent, 
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // TODO: Search for an auto scroll text that only scrolls if the text is to large
                  SizedBox(
                    width: 300,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // SizedBox(
                  //   width: 300,
                  //   height: 50,
                  //   child: Marquee(
                  //     text: widget.title,
                  //     style: const TextStyle(
                  //       fontSize: 28,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //     blankSpace: 20,
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                    splashRadius: 25,
                    icon: _isFavorite
                        ? const Icon(Icons.favorite,
                            size: 28, color: Colors.red)
                        : const Icon(Icons.favorite_outline,
                            size: 28, color: Colors.red),
                  )
                ],
              ),
              Text(widget.artist),
              const SizedBox(height: 20),
              Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(trackShape: CustomTrackShape()),
                    child: Slider(
                      thumbColor: Colors.deepPurple,
                      inactiveColor: const Color.fromARGB(50, 155, 39, 176),
                      activeColor: Colors.deepPurple,
                      value: sliderValue,
                      min: 0,
                      max: 100,
                      onChanged: (double value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[Text("Current"), Text("Total")],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isShuffle = !_isShuffle;
                      });
                    },
                    icon: Icon(
                      CupertinoIcons.shuffle,
                      color: _isShuffle ? Colors.purple : Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.backward_end_fill),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                    },
                    icon: _isPlaying
                        ? const Icon(CupertinoIcons.pause_fill)
                        : const Icon(CupertinoIcons.play_fill),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.forward_end_fill),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_repeatStatus == 2) {
                          _repeatStatus = 0;
                          return;
                        }

                        _repeatStatus++;
                      });
                    },
                    icon: _repeatStatus == 2
                        ? Icon(
                            CupertinoIcons.repeat_1,
                            color: _repeatStatus == 0
                                ? Colors.black
                                : Colors.purple,
                          )
                        : Icon(
                            CupertinoIcons.repeat,
                            color: _repeatStatus == 0
                                ? Colors.black
                                : Colors.purple,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _panel() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Lyrics",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    // FIXME: Sometimes when the panel is opened the close button does not work.
                    // FIXME: Sometimes when the panel is closed with the close button the press doet not work, only swipe
                    _panelController.close();
                  },
                  icon: const Icon(CupertinoIcons.chevron_down),
                ),
              )
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    _lyrics,
                    style: const TextStyle(
                        height: 1.6,
                        wordSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Creates a custom shape for the slider
class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}