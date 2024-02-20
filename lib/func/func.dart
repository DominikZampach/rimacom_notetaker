import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<String> loadJSON() {
  return rootBundle.loadString('assets/data.json');
}

dynamic getNumberOfItems() async {
  String jsonString = await loadJSON();
  Map<String, dynamic> data = json.decode(jsonString);
  return data['itemCount'];
}
