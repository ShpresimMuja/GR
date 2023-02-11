import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'NotificationService.dart';

class FireBaseNotifications {
  late FirebaseApp app;
  late String? token;

  FireBaseNotifications() {}

  Future<void> init() async {
    app = await Firebase.initializeApp();

    token = await FirebaseMessaging.instance.getToken();
    print('This is the token : ${token}');

    FirebaseMessaging.instance.getInitialMessage();

    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      NotificationService notificationService = NotificationService();
      notificationService.initializePlatformNotifications();

      await notificationService.showLocalNotification(
          id: 0,
          title: message.data['balance'],
          body: "Notification body!",
          payload: "payload!");
    });

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    //background
    FirebaseMessaging.onBackgroundMessage(BackgroundHandler);
  }
}

Future<void> BackgroundHandler(RemoteMessage message) async {
  NotificationService notificationService = NotificationService();
  notificationService.initializePlatformNotifications();

  await notificationService.showLocalNotification(
      id: 0,
      title: message.data['balance'],
      body: "Notification body!",
      payload: "payload!");
}
