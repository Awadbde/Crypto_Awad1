import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await messaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received foreground message: \${message.notification?.title}');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  }

  static Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: \${message.messageId}');
  }
}
