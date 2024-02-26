import 'package:flutter/material.dart';
import 'package:rimacom_notetaker/func/func.dart';
import 'package:rimacom_notetaker/widgets/note_card.dart';

final class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int numberOfItems = 0;
  late List allNotes;

  @override
  void initState() {
    setState(() {
      setVariables();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setVariables() async {
    int numberOfItemsCall = await getNumberOfItems();
    List allNotesCall = await getAllNotes();
    setState(() {
      numberOfItems = numberOfItemsCall;
      allNotes = allNotesCall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: appBar(context),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Center(
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                for (int i = 0; i < numberOfItems; i++)
                  NoteCard(noteInformations: allNotes[i]),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: actionButton(),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text(
            '"Best" notetaker',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      centerTitle: true,
      leading: Container(),
    );
  }

  IconButton actionButton() {
    return IconButton.filled(
        color: Theme.of(context).colorScheme.primary,
        onPressed: () {
          var uuid = createUUID();
          // TODO Create logic with creating new note
        },
        icon: const Icon(
          Icons.add,
          size: 70,
          color: Colors.white70,
        ));
  }
}
