import 'package:flutter/material.dart';
import 'package:rimacom_notetaker/func/func.dart';
import 'package:rimacom_notetaker/pages/create_note.dart';
import 'package:rimacom_notetaker/widgets/note_card.dart';

double? FULLPAGE_TITLE_FONT_SIZE = 25;
double? FULLPAGE_DATE_FONT_SIZE = 18;
double? APPBAR_FONT_SIZE = 26;

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    List allNotesCall = await getAllNotes();
    int numberOfItemsCall = await getNumberOfItems();
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
        body: bodyHomepage(context),
        floatingActionButton: actionButton(),
      ),
    );
  }

  Container bodyHomepage(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            for (int i = 0; i < numberOfItems; i++)
              NoteCard(noteInformations: allNotes[i]),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            '"Best" notetaker',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: APPBAR_FONT_SIZE),
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateNotePage(uuid: uuid)));
          // TODO Create logic with creating new note
        },
        icon: const Icon(
          Icons.add,
          size: 70,
          color: Colors.white70,
        ));
  }
}
