import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// This is a light theme color scheme based on given seed
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 9, 99, 190),
);

// And this is a dark theme color scheme with a different seed
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      // Custom dark theme setup
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,

        // The card styling with color and spacing
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),

        // The button styling using dark theme colors
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),

      // Custom light theme setup
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,

        // The AppBar with background and foreground color
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),

        // The card styling with color and spacing
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // The light theme button styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),

        // This is custom text style for titles
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 24,
          ),
        ),
      ),

      // This is how the system decides whether to use light or dark mode
      themeMode: ThemeMode.system,

      // And the starting screen of the app!
      home: Expenses(),
    ),
  );
}
