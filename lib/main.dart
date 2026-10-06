import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SpoopyFinderApp());
}

class SpoopyFinderApp extends StatelessWidget{
  const SpoopyFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Spoopy Finder',
      home: HomeScreen(),
    );
  }
}
