import 'package:flutter/material.dart';
import 'package:hangman_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hang-Man ',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
