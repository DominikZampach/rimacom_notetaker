import 'package:flutter/material.dart';
import 'package:rimacom_notetaker/pages/edit_note.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, top: 3.0),
                  child: Text(
                    noteInformations['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, top: 3.0),
                  child: Text(
                    '${noteInformations["created"].day}.${noteInformations["created"].month}. ${noteInformations["created"].year}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.5, bottom: 1.0, left: 8.0),
              child: Text(
                "${noteInformations['subtext']}",
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
