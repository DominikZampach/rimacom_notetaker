import 'package:flutter/material.dart';
import 'package:rimacom_notetaker/func/func.dart';

var numberOfItems = getNumberOfItems();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
          child: ListView(
        children: [for (int i = 0; i < numberOfItems; i++) Text(i.toString())],
      )),
      floatingActionButton: actionButton(),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: const Text("Best notetaker ever"),
      centerTitle: true,
    );
  }

  IconButton actionButton() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.add,
          size: 50,
        ));
  }
}
