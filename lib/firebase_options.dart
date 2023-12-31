// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
    

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
// /// ```dart
//  import 'firebase_options.dart';

//  await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//  );
// /// ```
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
    apiKey: 'AIzaSyD-i7du2O-qGNsOZZR36Kk_h1F-ACqS1cA',
    appId: '1:856043508172:web:88039aa2d7f60a2ae10d69',
    messagingSenderId: '856043508172',
    projectId: 'chatapptute-d02cb',
    authDomain: 'chatapptute-d02cb.firebaseapp.com',
    storageBucket: 'chatapptute-d02cb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAeVSYvap7iZrLlxH7xSp_WfVoPLrqGRPk',
    appId: '1:856043508172:android:bdbf5fb68e6ee129e10d69',
    messagingSenderId: '856043508172',
    projectId: 'chatapptute-d02cb',
    storageBucket: 'chatapptute-d02cb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAi-KPr3ZbdCEmNPRHKbXRzY4ZAPHccYn0',
    appId: '1:856043508172:ios:2534114c0194b07de10d69',
    messagingSenderId: '856043508172',
    projectId: 'chatapptute-d02cb',
    storageBucket: 'chatapptute-d02cb.appspot.com',
    iosBundleId: 'com.example.chatmessengerapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAi-KPr3ZbdCEmNPRHKbXRzY4ZAPHccYn0',
    appId: '1:856043508172:ios:b09c5bee5c508b6fe10d69',
    messagingSenderId: '856043508172',
    projectId: 'chatapptute-d02cb',
    storageBucket: 'chatapptute-d02cb.appspot.com',
    iosBundleId: 'com.example.chatmessengerapp.RunnerTests',
  );
}
