import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web belum dikonfigurasi');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError('iOS belum dikonfigurasi');
      default:
        throw UnsupportedError('Platform ini tidak didukung');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'MASUKKAN_API_KEY_ANDA_DARI_FIREBASE_CONSOLE',
    appId: 'MASUKKAN_APP_ID_ANDA',
    messagingSenderId: 'MASUKKAN_SENDER_ID',
    projectId: 'max-cafe-xxxx', // ID Project Anda
    storageBucket: 'max-cafe-xxxx.appspot.com',
  );
}
