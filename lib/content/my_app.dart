import 'package:flutter/material.dart';
import 'package:proyecto_palabras_v0/content/random_words.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'generador de palabras ',
      home: RandomWords(),
    );
  }
}