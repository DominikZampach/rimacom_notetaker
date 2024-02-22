import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';

Future<String> loadJSON() async {
  return await rootBundle.loadString('assets/data.json');
}

Future<int> getNumberOfItems() async {
  String jsonString = await loadJSON();
  Map<String, dynamic> data = json.decode(jsonString);
  return int.parse(data['itemCount'].toString());
}

Future<List> getAllNotes() async {
  String jsonString = await loadJSON();
  Map<String, dynamic> data = json.decode(jsonString);
  List output = [];
  for (int i = 0; i < int.parse(data['itemCount'].toString()); i++) {
    Map<String, dynamic> currentItem = {
      'id': data['items'][i]['id'],
      'title': data['items'][i]['title'],
      'text': data['items'][i]['text'],
      'subtext': data['items'][i]['subtext'],
      'creationDate': DateTime.parse(data['items'][i]['created']),
      'lastEdited': DateTime.parse(data['items'][i]['last-edit'])
    };
    output.add(currentItem);
  }
  return output;
}

String createSubtext(String text) {
  String output;
  output = text.substring(0, 20);
  return output;
}

String createUUID() {
  var uuid = Uuid();
  return uuid.v4();
}
