import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseModalBottomSheet extends StatefulWidget {
  String name;
  Widget child;

  ChooseModalBottomSheet({Key key, @required this.name, @required this.child})
      : super(key: key);

  @override
  _ChooseModalBottomSheetState createState() => _ChooseModalBottomSheetState();
}

class _ChooseModalBottomSheetState extends State<ChooseModalBottomSheet> {
  String name;
  Widget child;

  void initState() {
    super.initState();
    this.name = widget.name;
    this.child = widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(name),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => ListView(
                  scrollDirection: Axis.vertical,
                  children: [ShowBotSheetLayout(name, context), child],
                )).then((value) {
          setState(() {
            if (value != 'close') {
              name = value;
            }
          });
        });
      },
    );
  }
}

Widget ShowBotSheetLayout(String name, BuildContext context) {
  return Padding(
      padding: EdgeInsets.all(20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "$name",
          style: TextStyle(
              fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => {Navigator.pop(context, 'close')})
      ]));
}
