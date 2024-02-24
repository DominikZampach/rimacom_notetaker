import 'dart:convert';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Map<String, dynamic> trainingData = {
  "itemCount": 8,
  "items": [
    {
      "id": "8493871539d68992",
      "title": "Poznámka",
      "text":
          "Petr je gej, mega gej, je to kokot, nenavidim petra, je to nejvetsi kokot",
      "subtext": "Petr je gej, mega ge",
      "created": "2024-02-20 00:00:00"
    },
    {
      "id": "84938715-a711-4943-81f6-5f1239d68992",
      "title": "Test title",
      "text": "sdfasdfasdfasdfasdfafadsfsdfa\nDFASDFASDFASDFASDFASafasdf",
      "subtext": "sdfasdfasdfasdfasdfa",
      "created": "2024-02-20 00:00:00"
    },
    {
      "id": "84938715-a711-4943-81f6-5f1239d68992",
      "title": "Test title",
      "text": "sdfasdfasdfasdfasdfafadsfsdfa\nDFASDFASDFASDFASDFASafasdf",
      "subtext": "sdfasdfasdfasdfasdfa",
      "created": "2024-02-20 00:00:00"
    },
    {
      "id": "84938715-a711-4943-81f6-5f1239d68992",
      "title": "Test title",
      "text": "sdfasdfasdfasdfasdfafadsfsdfa\nDFASDFASDFASDFASDFASafasdf",
      "subtext": "sdfasdfasdfasdfasdfa",
      "created": "2024-02-20 00:00:00"
    },
    {
      "id": "84938715-a711-4943-81f6-5f1239d68992",
      "title": "Test title",
      "text": "sdfasdfasdfasdfasdfafadsfsdfa\nDFASDFASDFASDFASDFASafasdf",
      "subtext": "sdfasdfasdfasdfasdfa",
      "created": "2024-02-20 00:00:00"
    },
    {
      "id": "84938715-a711-4943-81f6-5f1239d68992",
      "title": "Test title",
      "text": "sdfasdfasdfasdfasdfafadsfsdfa\nDFASDFASDFASDFASDFASafasdf",
      "subtext": "sdfasdfasdfasdfasdfa",
      "created": "2024-02-20 00:00:00"
    },
    {
      "id": "84938715-a711-4943-81f6-5f1239d68992",
      "title": "Test title",
      "text": "sdfasdfasdfasdfasdfafadsfsdfa\nDFASDFASDFASDFASDFASafasdf",
      "subtext": "sdfasdfasdfasdfasdfa",
      "created": "2024-02-20 00:00:00"
    },
    {
      "id": "84938715-a711-4943-81f6-5f1239d68992",
      "title": "Test title",
      "text": "sdfasdfasdfasdfasdfafadsfsdfa\nDFASDFASDFASDFASDFASafasdf",
      "subtext": "sdfasdfasdfasdfasdfa",
      "created": "2024-02-20 00:00:00"
    }
  ]
};

Future<String> loadJSON() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String filePath = '${documentsDirectory.path}/data.json';
  File file = File(filePath);
  String jsonString = await file.readAsString();
  return jsonString;
}

Future<void> saveJSON(Map<String, dynamic> loadedJSON) async {
  Map<String, dynamic> loadedJSONString =
      createStringOfDatetimeObjects(loadedJSON);
  String updatedJSONString = json.encode(loadedJSONString);
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = documentsDirectory.path;
  File file = File('$path/data.json');
  print(file.path);
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
  Map<String, dynamic> data = json.decode(jsonString);
  return int.parse(data['itemCount'].toString());
}

Future<List> getAllNotes() async {
  createDataJSON();
  String jsonString = await loadJSON();
  Map<String, dynamic> data = json.decode(jsonString);
  List output = [];
  for (int i = 0; i < int.parse(data['itemCount'].toString()); i++) {
    Map<String, dynamic> currentItem = {
      'id': data['items'][i]['id'],
      'title': data['items'][i]['title'],
      'text': data['items'][i]['text'],
      'subtext': data['items'][i]['subtext'],
      'created': DateTime.parse(data['items'][i]['created']),
    };
    output.add(currentItem);
  }
  return output;
}

Future<void> saveToJSON(Map<String, dynamic> data) async {
  String jsonString = await loadJSON();
  Map<String, dynamic> loadedJSON = json.decode(jsonString);
  for (int i = 0; i < loadedJSON['itemCount']; i++) {
    if (loadedJSON["items"][i]["id"] == data["id"]) {
      // Item in json file found
      loadedJSON["items"][i] = data;
      // Override JSON file with loadedJSON
      await saveJSON(loadedJSON);
      break;
    }
  }
}

String createSubtext(String text) {
  String output;
  if (text.length == 20) {
    output = text.substring(0, 20);
  } else if (text.length > 21) {
    output = "${text.substring(0, 20)}...";
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
  //await file.writeAsString(json.encode(
  //    trainingData)); // TODO Delete this, it only loads training data!!!
  print('data.json file created at: $filePath');
}

Future<bool> doesDataJsonExist() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String filePath = '${documentsDirectory.path}/data.json';
  File file = File(filePath);
  return await file.exists();
}
