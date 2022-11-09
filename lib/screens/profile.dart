import 'package:flutter/material.dart';

// Inspiration: https://dribbble.com/shots/16979679-User-Profiles

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: <Widget>[
          Image(
            image: const AssetImage(
              'assets/profileImage.jpg',
            ),
            height: 200,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Material(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          maxRadius: 50,
                          child: Text("DM"),
                        ),
                      ),
                      Text("hello"),
                      Text("hello"),
                      Text("hello"),
                      Text("hello"),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
