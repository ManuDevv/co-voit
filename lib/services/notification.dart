import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static void initialize() {
    // pour ios
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
      print("Nouveau message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Nouveau message méthode 2");
    });
  }

  static Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }
}
