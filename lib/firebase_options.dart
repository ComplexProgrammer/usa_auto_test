// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'dart:io';

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
///
///
bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isIOS => !kIsWeb && Platform.isIOS;
bool get isWindows => !kIsWeb && Platform.isWindows;
bool get isWeb => kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDpWaFi5QLTNc-yY0ieMKJtGOmbm2ofBm4',
    appId: '1:755681568857:web:102b1b733df55baefe2948',
    messagingSenderId: '755681568857',
    projectId: 'c0mplex',
    authDomain: 'c0mplex.firebaseapp.com',
    storageBucket: 'c0mplex.appspot.com',
    measurementId: 'G-H8XGTS4B9J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_ie8EYtVItas8PKlBUoHOg9QipbMdMOM',
    appId: '1:755681568857:android:e9012758bd1f3b33fe2948',
    messagingSenderId: '755681568857',
    projectId: 'c0mplex',
    storageBucket: 'c0mplex.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFeBhmkEbUI0jpiIXgi4KbZGFP1qNBd_0',
    appId: '1:755681568857:ios:aaccffc1673cafecfe2948',
    messagingSenderId: '755681568857',
    projectId: 'c0mplex',
    storageBucket: 'c0mplex.appspot.com',
    androidClientId:
        '755681568857-d3rpvl79228uf8r0kptea523nocukb8a.apps.googleusercontent.com',
    iosClientId:
        '755681568857-mdmci4u022hpbpjmcelim0l5e4ro45uh.apps.googleusercontent.com',
    iosBundleId: 'com.example.usaAutoTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFeBhmkEbUI0jpiIXgi4KbZGFP1qNBd_0',
    appId: '1:755681568857:ios:8a7ecad73b9bd0fafe2948',
    messagingSenderId: '755681568857',
    projectId: 'c0mplex',
    storageBucket: 'c0mplex.appspot.com',
    androidClientId:
        '755681568857-d3rpvl79228uf8r0kptea523nocukb8a.apps.googleusercontent.com',
    iosClientId:
        '755681568857-fvup07q0h4v0hku88fjt5i8hcbgn0asn.apps.googleusercontent.com',
    iosBundleId: 'com.example.usaAutoTest.RunnerTests',
  );
}
