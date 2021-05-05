import 'package:flutter/material.dart';

class ChooseModalBottomSheet extends StatefulWidget {
  String name;

  ChooseModalBottomSheet({Key key, @required this.name}) : super(key: key);

  @override
  _ChooseModalBottomSheetState createState() => _ChooseModalBottomSheetState();
}

class _ChooseModalBottomSheetState extends State<ChooseModalBottomSheet> {
  String name;

  @override
  void initState() {
    super.initState();
    name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('$name'),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 800,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$name",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context))
                        ])
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
