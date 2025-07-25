import 'package:flutter/material.dart';
import 'city_selection_page.dart';

void main() {
  runApp(NamazVaktiApp());
}

class NamazVaktiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namaz Vakti',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: CitySelectionPage(), // başlangıçta şehir seçme ekranı gelsin
      debugShowCheckedModeBanner: false,
    );
  }
}
