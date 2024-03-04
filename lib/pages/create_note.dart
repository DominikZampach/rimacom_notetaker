import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:rimacom_notetaker/func/func.dart';
import 'package:rimacom_notetaker/func/note.dart';
import 'package:rimacom_notetaker/pages/homepage.dart';

class CreateNotePage extends StatefulWidget {
  final String uuid;
  const CreateNotePage({super.key, required this.uuid});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  late TextEditingController _controllerText;
  late TextEditingController _controllerTitle;
  late String text = "";
  late String title = "";
  late DateTime? date;

  @override
  void initState() {
    _controllerText = TextEditingController(text: text);
    _controllerTitle = TextEditingController(text: title);
    date = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    _controllerText.dispose();
    _controllerTitle.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? date = await showDatePickerDialog(
        context: context,
        initialDate: DateTime.now(),
        selectedDate: DateTime.now(),
        maxDate: DateTime.now(),
        minDate: DateTime(2000, 1, 1));
    return date;
  }

  void _saveTitle() {
    setState(() {
      title = _controllerTitle.text;
    });
  }

  void _saveNote() {
    setState(() {
      text = _controllerText.text;
    });
  }

  void _saveDate(DateTime? newDate) {
    setState(() {
      date = newDate;
    });
  }

  Future<void> _onLeadingBackSave() async {
    String jsonString = await loadJSON();
    Map<String, dynamic> data = await json.decode(jsonString);

    Note currentItem =
        Note(widget.uuid, title, text, createSubtext(text), date!);
    Map<String, dynamic> currentItemObject = convertNoteToMap(currentItem);

    data["items"].add(currentItemObject);
    data["itemCount"]++;

    await saveJSON(data);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCreatePage(context),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 12.0, bottom: 10.0),
                  child: TextField(
                    controller: _controllerTitle,
                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: 2,
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
                  padding: const EdgeInsets.only(
                      right: 16.0, top: 12.0, bottom: 10.0),
                  child: Text(
                    "Date: ${date?.day}.${date?.month}. ${date?.year}",
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
      ),
    );
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
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: APPBAR_FONT_SIZE,
          color: Colors.black),
      leading: IconButton(
          onPressed: () async {
            await _onLeadingBackSave();

            if (mounted) {
              Navigator.pushNamed(context, '/homepage');
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          )),
    );
  }
}
