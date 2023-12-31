
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:short_it/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        primarySwatch: Colors.teal,
        buttonTheme: const ButtonThemeData(buttonColor: Colors.teal),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
