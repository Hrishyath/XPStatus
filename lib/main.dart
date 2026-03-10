import 'package:flutter/material.dart';
import 'screens/status_screen.dart';

void main() {
  runApp(const LifeRPGApp());
}

class LifeRPGApp extends StatelessWidget {
  const LifeRPGApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StatusScreen(),
    );
  }
}