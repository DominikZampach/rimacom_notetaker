import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:rimacom_notetaker/func/func.dart';

class EditNotePage extends StatefulWidget {
  final Map<String, dynamic> noteInformations;
  const EditNotePage({Key? key, required this.noteInformations})
      : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: "${widget.noteInformations["text"]}");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveNote() {
    setState(() {
      widget.noteInformations["text"] = _controller.text;
      widget.noteInformations["subtext"] = createSubtext(_controller.text);
    });
    print("Note updated");
  }

  void _saveDate(DateTime date) {
    setState(() {
      widget.noteInformations["created"] = date;
    });
    print("Date change saved");
  }

  void _onLeadingBackSave(Map<String, dynamic> updatedNoteInformations) async {
    await saveToJSON(updatedNoteInformations);
    print("Note saved to JSON");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: SafeArea(
          child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text("Edit note")),
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        leading: IconButton(
            onPressed: () {
              _onLeadingBackSave(widget.noteInformations);
              Navigator.pushNamed(context, '/homepage');
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            )),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 12.0, bottom: 10.0),
                child: Text(
                  "${widget.noteInformations["title"]}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Clicked on date");
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, top: 12.0, bottom: 10.0),
                  child: Text(
                    "Date: ${widget.noteInformations["created"].day}.${widget.noteInformations["created"].month}. ${widget.noteInformations["created"].year}",
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 12.0),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 20),
              onChanged: (value) {
                _saveNote();
              },
            ),
          )
        ],
      ),
    );
  }
}
