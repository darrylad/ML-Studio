import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
    scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 235),
    fontFamily: 'Inter',
    useMaterial3: false,
  );
}
