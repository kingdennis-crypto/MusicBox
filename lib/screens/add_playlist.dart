import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddPlaylistScreen extends StatefulWidget {
  const AddPlaylistScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaylistScreen> createState() => _AddPlaylistScreenState();
}

class _AddPlaylistScreenState extends State<AddPlaylistScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Playlist"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      label: const Text('Name of playlist'),
                      // contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      label: Text('Description'),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
