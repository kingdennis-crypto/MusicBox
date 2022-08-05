import 'package:flutter/material.dart';

class FullscreenModal extends StatefulWidget {
  const FullscreenModal({Key? key}) : super(key: key);

  @override
  State<FullscreenModal> createState() => _FullscreenModalState();
}

class _FullscreenModalState extends State<FullscreenModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Center(
          child: Text('Hello modal!'),
        ),
      ),
    );
  }
}
