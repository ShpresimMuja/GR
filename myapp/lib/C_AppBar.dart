import 'package:flutter/material.dart';
import 'C_Card.dart';

class C_AppBar extends StatefulWidget {
  @override
  _C_AppBarState createState() => _C_AppBarState();
}

class _C_AppBarState extends State<C_AppBar> {
  var cards = List.of(<Widget>[Text("Hello World!")]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("ConReminder")),
        backgroundColor: Colors.lightBlue,
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
                color: Colors.lightBlue,
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
        itemBuilder: (context, index) => cards[0],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //cards.add(Text("Hello World"));
        },
        tooltip: 'Update Text',
        child: Icon(Icons.update),
      ),
    );
  }
}
