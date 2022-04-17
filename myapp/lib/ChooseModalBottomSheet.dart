import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ItemsCard.dart';

class ChooseModalBottomSheet extends StatefulWidget {
  late String name;
  late Widget child;

  ChooseModalBottomSheet({Key? key, required this.name, required this.child})
      : super(key: key);

  @override
  _ChooseModalBottomSheetState createState() => _ChooseModalBottomSheetState();
  String GetData() {
    print('Hello world');
    return this.name;
  }
}

class _ChooseModalBottomSheetState extends State<ChooseModalBottomSheet> {
  String LocalName = '';
  void initState() {
    super.initState();

    LocalName = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: UniqueKey(),
      child: Text(widget.name),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => ListView(
                  key: UniqueKey(),
                  children: [
                    ShowBotSheetLayout(LocalName, context),
                    widget.child
                  ],
                )).then((value) {
          setState(() {
            if (value.runtimeType == String) {
              if (value != 'close') {
                widget.name = value;
              }
            }
            if (value.runtimeType == CryptoData) {
              CryptoData c;
              c = value;
              widget.name = c.name;
            }
          });
        });
      },
    );
  }
}

Widget ShowBotSheetLayout(String name, BuildContext context) {
  return Padding(
      padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          name,
          style: TextStyle(
              fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => {Navigator.pop(context, 'close')})
      ]));
}
