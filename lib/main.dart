import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const SpoopyFinderApp());
}

class SpoopyFinderApp extends StatelessWidget{
  const SpoopyFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spooky Find',
      debugShowCheckedModeBanner: false,
      
      // Wire up custom themes
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, 
      
      home: const HomeScreen(),
    );
  }
}
