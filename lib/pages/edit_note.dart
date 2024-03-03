import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:rimacom_notetaker/func/func.dart';
import 'package:rimacom_notetaker/func/note.dart';
import 'package:rimacom_notetaker/pages/homepage.dart';

class EditNotePage extends StatefulWidget {
  final Note currentNote;
  const EditNotePage({super.key, required this.currentNote});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _controllerText;
  late TextEditingController _controllerTitle;

  @override
  void initState() {
    super.initState();
    _controllerText = TextEditingController(text: widget.currentNote.text);
    _controllerTitle = TextEditingController(text: widget.currentNote.title);
  }

  @override
  void dispose() {
    _controllerText.dispose();
    _controllerTitle.dispose();
    super.dispose();
  }

  void _saveNote() {
    setState(() {
      widget.currentNote.text = _controllerText.text;
      widget.currentNote.subtext = createSubtext(_controllerText.text);
    });
  }

  void _saveTitle() {
    setState(() {
      widget.currentNote.title = _controllerTitle.text;
    });
  }

  void _saveDate(DateTime? date) {
    setState(() {
      widget.currentNote.created = date!;
    });
  }

  void _onLeadingBackSave() async {
    await saveOneItemChange(widget.currentNote);
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? date = await showDatePickerDialog(
        context: context,
        initialDate: widget.currentNote.created,
        selectedDate: widget.currentNote.created,
        maxDate: DateTime.now(),
        minDate: DateTime(2000, 1, 1));
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarEditPage(context),
      body: bodyEditPage(context),
      floatingActionButton: floatingEditPage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  IconButton floatingEditPage() {
    return IconButton.filled(
      onPressed: () {
        deleteNoteByUUID(widget.currentNote.id);
        Navigator.pushNamed(context, '/homepage');
      },
      icon: const Icon(
        Icons.restore_from_trash,
        size: 40,
      ),
      iconSize: 40,
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
                  minLines: 1,
                  maxLines: 2,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      fontSize: FULLPAGE_TITLE_FONT_SIZE,
                      fontWeight: FontWeight.bold),
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
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 16.0, top: 12.0, bottom: 10.0),
                child: Text(
                  "Date: ${widget.currentNote.created.day}.${widget.currentNote.created.month}. ${widget.currentNote.created.year}",
                  style: TextStyle(
                      fontSize: FULLPAGE_DATE_FONT_SIZE,
                      fontStyle: FontStyle.italic),
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
              style: TextStyle(fontSize: FULLPAGE_TEXT_FONT_SIZE),
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
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: APPBAR_FONT_SIZE,
          color: Colors.black),
      leading: IconButton(
          onPressed: () {
            _onLeadingBackSave();
            Navigator.pushNamed(context, '/homepage');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          )),
    );
  }
}
