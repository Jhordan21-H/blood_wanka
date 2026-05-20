import 'package:flutter/material.dart';

class AppTheme {
  // Definimos el color rojo de Blood Wanka como constante privada
  static const Color _primaryRed = Color(0xFFE21B4C); 

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: _primaryRed,
      scaffoldBackgroundColor: Colors.white,
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), 
          ),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: _primaryRed, width: 2),
        ),
      ),
    );
  }
}