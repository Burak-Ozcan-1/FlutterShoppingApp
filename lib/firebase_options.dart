// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCuL1NCdYgJZPX2Xyaty315GGrb-Onw5tM',
    appId: '1:502169148770:web:d1eff12b79551f6f18603b',
    messagingSenderId: '502169148770',
    projectId: 'shoppingapp-7e21a',
    authDomain: 'shoppingapp-7e21a.firebaseapp.com',
    storageBucket: 'shoppingapp-7e21a.appspot.com',
    measurementId: 'G-SH01NF2M12',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDODgtkma1eggQkDhuSAuLUrsbjTDhrIiw',
    appId: '1:502169148770:android:682ef873919a974518603b',
    messagingSenderId: '502169148770',
    projectId: 'shoppingapp-7e21a',
    storageBucket: 'shoppingapp-7e21a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC64vTAiEOpwEIe5dZvJGJqCzDNMW0jqtI',
    appId: '1:502169148770:ios:c0e74dd2e092b29918603b',
    messagingSenderId: '502169148770',
    projectId: 'shoppingapp-7e21a',
    storageBucket: 'shoppingapp-7e21a.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC64vTAiEOpwEIe5dZvJGJqCzDNMW0jqtI',
    appId: '1:502169148770:ios:85a0d409c97fc15218603b',
    messagingSenderId: '502169148770',
    projectId: 'shoppingapp-7e21a',
    storageBucket: 'shoppingapp-7e21a.appspot.com',
    iosBundleId: 'com.example.todoapp.RunnerTests',
  );
}
