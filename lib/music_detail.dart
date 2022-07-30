import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicbox/store_controller.dart';

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
  final storeController = Get.put(StoreController());

  double sliderValue = 10;
  bool _isShuffle = false;
  int _repeatStatus = 0;
  int _panelIndex = 1; // 0 = Lyrics - 1 = Up Next

  final List<String> _items = [
    "Clients",
    "Designer",
    "Developer",
    "Director",
    "Employee",
    "Manager",
    "Worker",
    "Owner",
    "Deliverer",
    "Cashier",
  ];

  final List<String> menuItems = ['Add to playlist', 'Add to waitlist'];

  void goBack() {
    Navigator.pop(context);
  }

  void onSelectMenu(item) {
    switch (item) {
      case 'Add to playlist':
        print('Add to playlist');
        break;
      case 'Add to waitlist':
        print('Add to waitlist');
        break;
    }
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
          PopupMenuButton(
            onSelected: onSelectMenu,
            itemBuilder: (context) {
              return menuItems.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.more_horiz),
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
                scale: storeController.isPlaying.value ? 1 : 0.75,
                duration: const Duration(milliseconds: 200),
                curve: storeController.isPlaying.value
                    ? Curves.easeOutCubic
                    : Curves.easeInCubic,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: Colors.deepPurpleAccent,
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFF06083D),
                        image: DecorationImage(
                          image: AssetImage('assets/ttten.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                    // width: 300,
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // setState(() {
                          //   _panelIndex = 1;
                          // });
                          _panelController.open();
                        },
                        splashRadius: 25,
                        icon: const Icon(CupertinoIcons.list_number),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (storeController.favoriteSongs
                                .contains(widget.title)) {
                              storeController.removeFavoriteSong(widget.title);
                            } else {
                              storeController.addFavoriteSong(widget.title);
                            }
                          });
                        },
                        splashRadius: 25,
                        icon: Icon(
                          storeController.favoriteSongs.contains(widget.title)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          size: 28,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
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
                        storeController
                            .updateIsPlaying(!storeController.isPlaying.value);
                      });
                    },
                    icon: storeController.isPlaying.value
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
                    icon: Icon(
                      _repeatStatus == 2
                          ? CupertinoIcons.repeat_1
                          : CupertinoIcons.repeat,
                      color: _repeatStatus == 0 ? Colors.black : Colors.purple,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _panelIndex = 0;
                      });
                    },
                    child: Text(
                      "Lyrics",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color:
                            _panelIndex == 0 ? Colors.blue : Colors.blue[200],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _panelIndex = 1;
                      });
                    },
                    child: Text(
                      "Up Next",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color:
                            _panelIndex == 1 ? Colors.blue : Colors.blue[200],
                      ),
                    ),
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                clipBehavior: Clip.hardEdge,
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
        ),
        const Divider(),
        // _lyricsWidget()
        _panelIndex == 0 ? _lyricsWidget() : _upNext()
      ],
    );
  }

  Widget _lyricsWidget() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, 5, 20, MediaQuery.of(context).padding.bottom),
            child: Text(
              _lyrics,
              style: const TextStyle(
                height: 1.6,
                wordSpacing: 2,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _upNext() {
    // final List<int> items = List<int>.generate(50, (int index) => index);

    void reorderData(int oldIndex, int newIndex) {
      setState(() {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }

        final String item = _items.removeAt(oldIndex);
        _items.insert(newIndex, item);
      });
    }

    return Expanded(
      child: ReorderableListView.builder(
        buildDefaultDragHandles: true,
        header: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text('This is the header'),
        ),
        footer: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text('End of the list'),
        ),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        onReorder: reorderData,
        itemCount: _items.length,
        itemBuilder: (context, index) => ListTile(
          key: ValueKey(_items[index]),
          title: Text(_items[index]),
          subtitle: const Text('Subtitle'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: AspectRatio(
            aspectRatio: 1 / 1,
            child: Material(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          trailing: ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle),
          ),
        ),
        proxyDecorator: (child, index, animation) => Material(
          elevation: 20,
          child: child,
        ),
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
