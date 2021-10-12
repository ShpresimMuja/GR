import 'package:flutter/material.dart';
import 'ChooseModalBottomSheet.dart';
import 'ItemsCard.dart';

class C_Card extends StatefulWidget {
  @override
  _C_CardState createState() => _C_CardState();
}

class _C_CardState extends State<C_Card> {
  String name;
  UniqueKey tileKey;

  void nameCallback() {}
  ChooseModalBottomSheet condition;
  ChooseModalBottomSheet action;
  double Value;

  ItemsCard card;

  @override
  void initState() {
    super.initState();

    Value = 0.0;

    condition =
        ChooseModalBottomSheet(name: 'Select Coin :', child: ItemsCard());

    action = ChooseModalBottomSheet(
        name: 'Select Action',
        child: Column(children: [
          actionButton('Notify'),
          actionButton('Email'),
          actionButton('Alarm')
        ]));
  }

  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          maintainState: true,
          onExpansionChanged: (bool open) {
            setState(() {});
          },
          title: Text('Conditional Reminder.'),
          children: [
            Container(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Condition:",
                        style: TextStyle(fontSize: 20, color: Colors.green)))),
            Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Coin"),
                      condition,
                      SizedBox(
                          width: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Value:'),
                            //autofocus: true,
                            onTap: () {},
                            onSubmitted: (value) {
                              Value = double.tryParse(value);
                            },
                          )),
                    ])),
            Container(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Action:",
                        style: TextStyle(fontSize: 22, color: Colors.green)))),
            Padding(padding: EdgeInsets.all(10), child: action),
            Center(
              child: TextButton(
                child: Text('Apply'),
                onPressed: () {
                  print(Value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton(String name) {
    return Center(
        child: TextButton(
      child: Text(name),
      onPressed: () {
        setState(() {
          Navigator.pop(context, name);
        });
      },
    ));
  }
}

class GetData {}
