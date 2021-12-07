import 'package:flutter/material.dart';
import 'C_Card.dart';

class C_AppBar extends StatefulWidget {
  @override
  _C_AppBarState createState() => _C_AppBarState();
}

class _C_AppBarState extends State<C_AppBar> {
  var cards = List.of(<Widget>[C_Card()]);
  var items = List.generate(1, (index) => 'Item ${index + 1}');

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
        onPressed: () {
          setState(() {
            cards.add(C_Card());
            var index = items.length;
            items.add('Item ${index + 1}');
          });
        },
        tooltip: 'Update Text',
        child: Icon(Icons.add),
      ),
    );
  }
}
