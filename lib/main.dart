import 'package:flutter/material.dart';
import 'package:rimacom_notetaker/pages/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notetaking app',
      themeMode: ThemeMode.light,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.cyan,
              primary: Colors.cyan,
              background: const Color.fromARGB(255, 248, 248, 248),
              secondary: const Color.fromARGB(255, 157, 234, 244),
              brightness: Brightness.light)),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/homepage': (context) => const HomePage(),
      },
    );
  }
}
