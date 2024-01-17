import 'package:flutter/material.dart';
import 'package:usa_auto_test/main.dart';

// ignore: import_of_legacy_library_into_null_safe
// import 'package:splashscreen/splashscreen.dart';
class SplashApp extends StatelessWidget {
  const SplashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General knowledge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    );
  }
}
