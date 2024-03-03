import 'dart:convert';
import 'dart:io';
import 'package:rimacom_notetaker/func/note.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

Map<String, dynamic> trainingData = {
  "itemCount": 2,
  "items": [
    {
      "id": "84938715-a711-4943-81f6-5f1239d156489",
      "title": "Poznámka",
      "text":
          "Petr je gej, mega gej, je to kokot, nenavidim petra, je to nejvetsi kokot",
      "subtext": "Petr je gej, mega ge...",
      "created": "2024-02-20 00:00:00"
    },
    {
      "id": "84938715-a711-4943-81f6-5f1239d68992",
      "title": "Test",
      "text":
          "Petrus, nejde nic, kokotko, picus, maja, vojta, pavel davel, hulejnik, rosnik",
      "subtext": "Petrus, nejde nic, k...",
      "created": "2024-02-20 00:00:00"
    },
  ]
};

Map<String, dynamic> defaultInput = {"itemCount": 0, "items": []};

Future<String> loadJSON() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String filePath = '${documentsDirectory.path}/data.json';
  File file = File(filePath);
  String jsonString = await file.readAsString();
  return jsonString;
}

Map<String, dynamic> convertNoteToMap(Note note) {
  Map<String, dynamic> output = {
    'id': note.id,
    'title': note.title,
    'text': note.text,
    'subtext': note.subtext,
    'created': note.created
  };
  return output;
}

Future<void> saveJSON(Map<String, dynamic> loadedJSON) async {
  Map<String, dynamic> loadedJSONString =
      createStringOfDatetimeObjects(loadedJSON);
  String updatedJSONString = json.encode(loadedJSONString);
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = documentsDirectory.path;
  File file = File('$path/data.json');
  await file.writeAsString(updatedJSONString);
}

Map<String, dynamic> createStringOfDatetimeObjects(
    Map<String, dynamic> loadedJSON) {
  for (int i = 0; i < loadedJSON["itemCount"]; i++) {
    loadedJSON["items"][i]["created"] =
        loadedJSON["items"][i]["created"].toString();
  }
  return loadedJSON;
}

Future<int> getNumberOfItems() async {
  String jsonString = await loadJSON();
  Map<String, dynamic> loadedJson = json.decode(jsonString);
  return loadedJson['itemCount'];
}

Future<List<Note>> getAllNotes() async {
  await createDataJSON();
  String jsonString = "";
  jsonString = await loadJSON();
  while (jsonString == "") {
    sleep(const Duration(milliseconds: 10));
  }
  Map<String, dynamic> loadedJson = json.decode(jsonString);
  List<Note> output = [];
  for (int i = 0; i < int.parse(loadedJson['itemCount'].toString()); i++) {
    Note currentItem = Note(
        loadedJson['items'][i]['id'].toString(),
        loadedJson['items'][i]['title'].toString(),
        loadedJson['items'][i]['text'].toString(),
        createSubtext(loadedJson['items'][i]['text']),
        DateTime.parse(loadedJson['items'][i]['created']));
    output.add(currentItem);
  }
  return output;
}

Future<void> saveOneItemChange(Note currentNote) async {
  Map<String, dynamic> currentNoteObject = convertNoteToMap(currentNote);
  String jsonString = "";
  jsonString = await loadJSON();
  while (jsonString == "") {
    sleep(const Duration(milliseconds: 10));
  }
  Map<String, dynamic> loadedJSON = json.decode(jsonString);
  for (int i = 0; i < loadedJSON['itemCount']; i++) {
    if (loadedJSON["items"][i]["id"] == currentNote.id) {
      loadedJSON["items"][i] = currentNoteObject;
      break;
    }
  }
  await saveJSON(loadedJSON);
}

String createSubtext(String text) {
  String output;
  if (text.length == 30) {
    output = text.substring(0, 30);
  } else if (text.length > 31) {
    output = "${text.substring(0, 30)}...";
  } else {
    output = text;
  }
  return output;
}

String createUUID() {
  var uuid = const Uuid();
  return uuid.v4();
}

Future<void> createDataJSON() async {
  if (await doesDataJsonExist()) {
    return;
  }
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String filePath = '${documentsDirectory.path}/data.json';
  File file = File(filePath);
  await file
      .writeAsString(json.encode(defaultInput));
}

Future<bool> doesDataJsonExist() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String filePath = '${documentsDirectory.path}/data.json';
  File file = File(filePath);
  return await file.exists();
}

void deleteNoteByUUID(String uuid) async {
  String jsonString = await loadJSON();
  Map<String, dynamic> loadedData = json.decode(jsonString);
  for (int i = 0; i < loadedData["itemCount"]; i++) {
    if (loadedData["items"][i]["id"] == uuid) {
      loadedData["items"].removeAt(i);
      loadedData["itemCount"]--;
      await saveJSON(loadedData);
      return;
    }
  }
}
