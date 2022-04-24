import 'package:flutter/material.dart';
import 'ChooseModalBottomSheet.dart';
import 'ItemsCard.dart';
import 'NotificationData.dart';

class C_Card extends StatefulWidget {
  late String Id;
  String name = '';
  late double Value = 0.0;
  double getValue() {
    return Value;
  }

  C_Card({required this.Value}) {
    this.Value = Value;
  }

  Map<String, dynamic> toJson() {
    print('this was called ');

    return {
      'id': 'id',
      'condition': 'CryptoPrice',
      'value': this.Value.toString(),
      'action': 'Standard',
    };
  }

  @override
  _C_CardState createState() => _C_CardState();
}

class _C_CardState extends State<C_Card> {
  late ChooseModalBottomSheet condition;
  late ChooseModalBottomSheet action;
  late NotificationService service;
  late double Value = 0.0;

  late ItemsCard card;

  @override
  void initState() {
    super.initState();

    service = NotificationService();

    Value = widget.Value;

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
            setState(() {
              widget.name = condition.name;
            });
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
                            decoration: InputDecoration(
                                hintText: widget.Value.toString(),
                                labelText: 'Value:'),
                            //autofocus: true,
                            onTap: () {},
                            onSubmitted: (value) {
                              widget.Value = double.parse(value);
                              print(widget.Value);
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
                onPressed: () async {
                  service.showNotifications('Notification', 'body');
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
          print(condition.name);

          print(name);
        });
      },
    ));
  }
}
