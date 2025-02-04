import 'package:flutter/material.dart';
import 'package:language_translator/screen/language_translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Language Translator Application',
    debugShowCheckedModeBanner: false,
      home: LanguageTranslator(),
    );
  }
}
