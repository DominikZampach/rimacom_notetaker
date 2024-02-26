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
  late TextEditingController _controllerText;
  late TextEditingController _controllerTitle;

  @override
  void initState() {
    super.initState();
    _controllerText =
        TextEditingController(text: "${widget.noteInformations["text"]}");
    _controllerTitle =
        TextEditingController(text: "${widget.noteInformations["title"]}");
  }

  @override
  void dispose() {
    _controllerText.dispose();
    _controllerTitle.dispose();
    super.dispose();
  }

  void _saveNote() {
    setState(() {
      widget.noteInformations["text"] = _controllerText.text;
      widget.noteInformations["subtext"] = createSubtext(_controllerText.text);
    });
    print("Note updated");
  }

  void _saveTitle() {
    setState(() {
      widget.noteInformations["title"] = _controllerTitle.text;
    });
  }

  void _saveDate(DateTime? date) {
    setState(() {
      widget.noteInformations["created"] = date;
    });
    print("Date change saved");
  }

  void _onLeadingBackSave(Map<String, dynamic> updatedNoteInformations) async {
    await saveToJSON(updatedNoteInformations);
    print("Note saved to JSON");
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? date = await showDatePickerDialog(
        context: context,
        initialDate: widget.noteInformations["created"],
        selectedDate: widget.noteInformations["created"],
        maxDate: DateTime.now(),
        minDate: DateTime(2000, 1, 1));
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarEditPage(context),
      body: bodyEditPage(context),
      floatingActionButton: IconButton.filled(
          onPressed: () {},
          icon: const Icon(
            Icons.restore_from_trash,
            size: 12,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Column bodyEditPage(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 12.0, bottom: 10.0),
                child: TextField(
                  controller: _controllerTitle,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    _saveTitle();
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                DateTime? newDate = await _pickDate(context);
                _saveDate(newDate);
                print("Clicked on date");
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 16.0, top: 12.0, bottom: 10.0),
                child: Text(
                  "Date: ${widget.noteInformations["created"].day}.${widget.noteInformations["created"].month}. ${widget.noteInformations["created"].year}",
                  style: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .secondary
                      .withOpacity(0.8))),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 12.0),
            child: TextField(
              controller: _controllerText,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(border: InputBorder.none),
              onChanged: (value) {
                _saveNote();
              },
            ),
          ),
        ),
      ],
    );
  }

  AppBar appBarEditPage(BuildContext context) {
    return AppBar(
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
    );
  }
}
