import 'package:flutter/material.dart';
import 'package:rimacom_notetaker/pages/edit_note.dart';

double? CARD_TITLE_FONT_SIZE = 25;
double? CARD_SUBTEXT_FONT_SIZE = 22;
double? CARD_DATE_FONT_SIZE = 20;

class NoteCard extends StatelessWidget {
  final Map<String, dynamic> noteInformations;
  const NoteCard({Key? key, required this.noteInformations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                EditNotePage(noteInformations: noteInformations)));
      },
      child: Container(
        // TODO přidat Gesture
        margin: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
                width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.only(right: 2.0, left: 8.0, top: 3.0),
                  child: Text(
                    noteInformations['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: CARD_TITLE_FONT_SIZE),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 8.0, left: 2.0, top: 3.0),
                child: Text(
                  '${noteInformations["created"].day}.${noteInformations["created"].month}. ${noteInformations["created"].year}',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: CARD_DATE_FONT_SIZE),
                ),
              ),
            ]),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 2.5, bottom: 6.0, left: 8.0),
              child: Text(
                "${noteInformations['subtext']}",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: CARD_SUBTEXT_FONT_SIZE),
              ),
            )
          ],
        ),
      ),
    );
  }
}
