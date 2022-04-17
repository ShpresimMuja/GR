import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Client extends StatefulWidget {
  late WebSocketChannel channel;
  Client({required String? uri}) {
    channel = WebSocketChannel.connect(
      Uri.parse(uri!),
    );
    print('hello World!!');
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  void Recieve() {
    StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        return Text(snapshot.hasData ? '${snapshot.data}' : '');
      },
    );
  }
}
