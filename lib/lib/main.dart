import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const SpoopyFinder());
}

class SpoopyFinder extends StatelessWidget {
  const SpoopyFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spoopy Finder',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}