// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyAcnNh_b6Fr1MEcx04X2bilBY_QZHmRBeY',
    appId: '1:1074194273605:web:bfafb676d967697832da2c',
    messagingSenderId: '1074194273605',
    projectId: 'specno-a5146',
    authDomain: 'specno-a5146.firebaseapp.com',
    storageBucket: 'specno-a5146.appspot.com',
    measurementId: 'G-N3TL3BVWDQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6b866XzE4Jn8k63F9opItEX3KBo3koZw',
    appId: '1:1074194273605:android:1a8c265af5b0d74032da2c',
    messagingSenderId: '1074194273605',
    projectId: 'specno-a5146',
    storageBucket: 'specno-a5146.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATi-70fQzZJnUYS1d6bDTrk7ONU4Bmmjc',
    appId: '1:1074194273605:ios:5ea5f133546215df32da2c',
    messagingSenderId: '1074194273605',
    projectId: 'specno-a5146',
    storageBucket: 'specno-a5146.appspot.com',
    iosBundleId: 'com.specno.roySpecnoAssessment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyATi-70fQzZJnUYS1d6bDTrk7ONU4Bmmjc',
    appId: '1:1074194273605:ios:5ea5f133546215df32da2c',
    messagingSenderId: '1074194273605',
    projectId: 'specno-a5146',
    storageBucket: 'specno-a5146.appspot.com',
    iosBundleId: 'com.specno.roySpecnoAssessment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAcnNh_b6Fr1MEcx04X2bilBY_QZHmRBeY',
    appId: '1:1074194273605:web:6ceb5833a39b07a532da2c',
    messagingSenderId: '1074194273605',
    projectId: 'specno-a5146',
    authDomain: 'specno-a5146.firebaseapp.com',
    storageBucket: 'specno-a5146.appspot.com',
    measurementId: 'G-X72NXEBD5K',
  );
}
