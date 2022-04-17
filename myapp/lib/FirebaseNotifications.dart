import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FireBaseNotifications {
  static FireBaseNotifications _fireBaseNotifications = FireBaseNotifications();

  factory FireBaseNotifications() {
    print('Hello World');
    return _fireBaseNotifications;
  }

  Future<void> init() async {}
}
