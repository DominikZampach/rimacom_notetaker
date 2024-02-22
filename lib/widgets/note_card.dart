import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Map<String, dynamic> noteInformations;
  const NoteCard({Key? key, required this.noteInformations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO přidat Gesture
      margin: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 2)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                noteInformations['title'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                '${noteInformations["lastEdited"].day}.${noteInformations["lastEdited"].month}. ${noteInformations["lastEdited"].year}',
                style:
                    const TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              )
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            "${noteInformations['subtext']}...",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 25),
          )
        ],
      ),
    );
  }
}
