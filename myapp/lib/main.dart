import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "C_AppBar.dart";
import 'NotificationData.dart';
import 'dart:async' show Future;

late FirebaseApp app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp();

  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  late NotificationService service;

  late FirebaseFunctions functions = FirebaseFunctions.instance;

  late List data;

  //FireBaseNotifications notifications = FireBaseNotifications();
  @override
  void initState() {
    super.initState();
    service = NotificationService();

    FirebaseMessaging.instance.getInitialMessage();
    writeMessage('From flutter');

    service.showNotifications('titile', 'body');

    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification == null) return;
      service.showNotifications(
          message.notification!.title, message.notification!.body);
    });

    //background
    FirebaseMessaging.onBackgroundMessage(BackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "ConReminder", home: C_AppBar());
  }

  Future<void> writeMessage(String message) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('writeMessage');
    final resp = await callable.call(<String, dynamic>{
      'text': message,
    });
    print("result: ${resp.data}");
  }
}

Future<void> BackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}
