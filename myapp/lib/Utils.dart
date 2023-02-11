import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

String url = "http://192.168.0.38:8080";

class ServerInfo {
  int id = 0;
  int deviceID = 0;
  String taskType = '';
  String FCM = '';
  String Coin = '';
  double Price = 0.0;

  ServerInfo(
      {required this.id,
      required this.deviceID,
      required this.taskType,
      required this.FCM,
      required this.Coin,
      required this.Price}) {}

  ServerInfo.empty() {}

  factory ServerInfo.fromJson(Map<dynamic, dynamic> json) {
    if (json.runtimeType == Null) {
      print('this argument is invalid');
    }

    return ServerInfo(
        id: json['id'] as int,
        deviceID: json['deviceID'] as int,
        taskType: json['tasktype'] as String,
        FCM: json['FCM'] as String,
        Coin: json['Coin'] as String,
        Price: json['Price'] as double);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deviceID': deviceID,
      'taskType': taskType,
      'FCM': FCM,
      'Coin': Coin,
      'Price': Price
    };
  }
}

Future<String> GetFromDataBase() async {
  var response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw "Unable to retrieve posts.";
  }
}

Future<String> SendtoDataBase(ServerInfo info) async {
  var response = await http
      .post(Uri.parse(url), body: jsonEncode(info.toJson()), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw "Unable to retrieve posts.";
  }
}

//save data to file code

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  print(path);
  return File('$path/cards.json');
}

Future<File> writetoFile(String stream) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString(stream);
}

Future<String> readStream() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();
    print(contents);

    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return '';
  }
}
