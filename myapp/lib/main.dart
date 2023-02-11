import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'Utils.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'NotificationService.dart';
import "C_AppBar.dart";
import 'FirebaseNotifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FireBaseNotifications notifications = FireBaseNotifications();

  await notifications.init();

  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  //FireBaseNotifications notifications = FireBaseNotifications();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "ConReminder", home: C_AppBar());
  }
}
