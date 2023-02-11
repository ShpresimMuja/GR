import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'C_Card.dart';
import 'Utils.dart';

class C_AppBar extends StatefulWidget {
  @override
  _C_AppBarState createState() => _C_AppBarState();
}

class _C_AppBarState extends State<C_AppBar> {
  late var cards = List.of([]);
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
              key: UniqueKey(),

              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                  cards.removeAt(index);
                  print(json.encode(cards));
                  writetoFile(json.encode(cards));
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
            cards.add(C_Card.info(
              info: ServerInfo.empty(),
            ));
            var index = items.length;
            for (var item in cards) {
              print(item.getValue());
            }

            items.add('Item ${index + 1}');
          });

          String stream = json.encode(cards);

          writetoFile(stream);
        },
        tooltip: 'Update Text',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> runAsync() async {
    var list = json.decode(await readStream()) as List;

    var index = list.length;
    //print(list[0]['Price']);

    //this is the function i have to modify so it reads onjects from file on start up.

    setState(() {
      for (int i = 0; i < list.length; i++) {
        //double value = double.parse(list[i]);

        print(list[i].runtimeType);
        var object = Map<String, dynamic>.from(list[i]);

        print(object);

        var info = ServerInfo.empty();

        cards.add(
          C_Card.info(info: info),
        );

        items.add('Item ${index + 1}');
      }
    });
  }
}
