import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  // Light Theme Configuration
  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF000000),
        brightness: Brightness.light,
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF000000),
        onSurfaceVariant: const Color(0xFF000000),
        secondary: const Color(0xFF000000),
        surfaceContainerHigh: const Color(0xFFFFFFFF),
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.creepsterTextTheme(base.textTheme),
    );
  }

  // Dark Theme Configuration
  static ThemeData get darkTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFFFFFF),
        brightness: Brightness.dark,
        onSurface: const Color(0xFFFFFFFF),
        onSurfaceVariant: const Color(0xFF121214),
        secondary: const Color(0xFF00FFCC),
        surfaceContainerHigh: const Color(0xFFFF8E2B),
      ),
    ); 

    return base.copyWith(
      textTheme: GoogleFonts.creepsterTextTheme(base.textTheme),
    );
  }
}