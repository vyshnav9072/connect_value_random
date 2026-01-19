import 'package:flutter/material.dart';

import 'authentication/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Seclob',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        // useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

