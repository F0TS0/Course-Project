import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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
    apiKey: 'AIzaSyBg2QXbP8isia0IklHCxA6XClm3UCKOSvM',
    appId: '1:736996245677:web:1d950f0cf24faee6c90624',
    messagingSenderId: '736996245677',
    projectId: 'app-project-6fc63',
    authDomain: 'app-project-6fc63.firebaseapp.com',
    storageBucket: 'app-project-6fc63.firebasestorage.app',
    measurementId: 'G-ZEMQFBME1R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBB2AiU0KyUHQJ5AaGBAEvAN9zHoWvr6hQ',
    appId: '1:736996245677:android:e664bfe861ced4dac90624',
    messagingSenderId: '736996245677',
    projectId: 'app-project-6fc63',
    storageBucket: 'app-project-6fc63.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUwon1fbM4Dc9A8DhhlW2D1N0MvJSD0sw',
    appId: '1:736996245677:ios:18bf89ef4960af54c90624',
    messagingSenderId: '736996245677',
    projectId: 'app-project-6fc63',
    storageBucket: 'app-project-6fc63.firebasestorage.app',
    iosBundleId: 'com.course.translatorApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUwon1fbM4Dc9A8DhhlW2D1N0MvJSD0sw',
    appId: '1:736996245677:ios:18bf89ef4960af54c90624',
    messagingSenderId: '736996245677',
    projectId: 'app-project-6fc63',
    storageBucket: 'app-project-6fc63.firebasestorage.app',
    iosBundleId: 'com.course.translatorApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBg2QXbP8isia0IklHCxA6XClm3UCKOSvM',
    appId: '1:736996245677:web:855fb59cc4db0c9dc90624',
    messagingSenderId: '736996245677',
    projectId: 'app-project-6fc63',
    authDomain: 'app-project-6fc63.firebaseapp.com',
    storageBucket: 'app-project-6fc63.firebasestorage.app',
    measurementId: 'G-XTLJL71BK0',
  );

}