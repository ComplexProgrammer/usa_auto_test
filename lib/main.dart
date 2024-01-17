import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:usa_auto_test/firebase_options.dart';
import 'package:usa_auto_test/navbar.dart';
import 'package:usa_auto_test/splash_screen.dart';
import 'package:usa_auto_test/screens/group/components/body.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  unawaited(MobileAds.instance.initialize());
  runApp(const SplashApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: const Text('Usa Auto Test'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Body(),
      ),
      // home: GroupScreen(),
    );
  }
}
