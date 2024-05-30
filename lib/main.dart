import 'package:flutter/material.dart';

import 'package:flutter_application_assignments_2_24_05_30/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color.fromARGB(255, 230, 77, 60),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color.fromARGB(255, 236, 171, 161),
          ),
        ),
        cardColor: const Color.fromARGB(255, 255, 255, 255),
        hintColor: const Color.fromARGB(255, 230, 77, 60),
      ),
      home: const HomeScreen(),
    );
  }
}
