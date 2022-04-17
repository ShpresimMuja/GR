import 'dart:convert';

import 'package:flutter/material.dart';
import 'C_Card.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class C_AppBar extends StatefulWidget {
  @override
  _C_AppBarState createState() => _C_AppBarState();
}

class _C_AppBarState extends State<C_AppBar> {
  late var cards = List.of(<Widget>[]);
  late List<C_Card> Scards = List.of([]);
  late List<String> items = [];

  @override
  void initState() {
    super.initState();
    runAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("ConReminder")),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Preferences',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text('About',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(
              key: Key(item),

              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                  cards.removeAt(index);
                  Scards.removeAt(index);
                  print(json.encode(Scards));
                  writetoFile(json.encode(Scards));
                });

                // Then show a snackbar.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$item dismissed')));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: cards[index],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            cards.add(C_Card());
            Scards.add(C_Card());
            var index = items.length;
            for (var item in Scards) {
              print(item.Value);
            }

            items.add('Item ${index + 1}');
          });

          String stream = json.encode(Scards);

          writetoFile(stream);
        },
        tooltip: 'Update Text',
        child: Icon(Icons.add),
      ),
    );
  }

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

  Future<void> runAsync() async {
    var list = json.decode(await readStream()) as List;

    var index = list.length;
    //this is the function i have to modify so it reads onjects from file on start up.

    setState(() {
      for (int i = 0; i < list.length; i++) {
        cards.add(C_Card());
        Scards.add(C_Card());

        items.add('Item ${index + 1}');
      }
    });
  }
}
