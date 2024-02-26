import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

class CreateNotePage extends StatefulWidget {
  final String uuid;
  const CreateNotePage({Key? key, required this.uuid}) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBarCreatePage(context));
  }

  AppBar appBarCreatePage(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: SafeArea(
        child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text("Create note")),
      ),
      centerTitle: true,
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
      leading: IconButton(
          onPressed: () {
            // TODO Add function to save into json
            Navigator.pushNamed(context, '/homepage');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          )),
    );
  }
}
