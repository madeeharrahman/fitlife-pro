import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FitLifePro());
}

class FitLifePro extends StatelessWidget {
  const FitLifePro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "FitLife Pro",

      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),

      home: const HomeScreen(),
    );
  }
}
