import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 30, 229, 63);
  static const Color secondaryColor = Color.fromARGB(255, 30, 229, 63);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardBackgroundColor = Color(0xFFFFFFFF);
  static const Color textColor = Color.fromARGB(255, 225, 15, 15);
  static const Color buttonColor = Color(0xFFFF7043); 

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
    cardTheme: CardTheme(
      color: cardBackgroundColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColor, fontSize: 16),
      bodyMedium: TextStyle(color: textColor, fontSize: 14),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: buttonColor,
      textTheme: ButtonTextTheme.primary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: buttonColor, // Random Joke button color
    ),
  );
}
