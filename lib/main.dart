import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(NamazVaktiApp());
}

class NamazVaktiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namaz Vakti',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
