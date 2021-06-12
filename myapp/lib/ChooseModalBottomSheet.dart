import 'package:flutter/material.dart';
import "ItemsCard.dart";

class ChooseModalBottomSheet extends StatefulWidget {
  String name;
  Widget child;

  ChooseModalBottomSheet({Key key, @required this.name, this.child})
      : super(key: key);

  @override
  _ChooseModalBottomSheetState createState() => _ChooseModalBottomSheetState();
}

class _ChooseModalBottomSheetState extends State<ChooseModalBottomSheet> {
  String name;
  Widget child;
  int x = 0;

  var list = List.of(<Widget>[]);

  @override
  void initState() {
    super.initState();
    name = widget.name;
    child = widget.child;

    list.add(Padding(
                padding: EdgeInsets.all(20),
                child: 
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
                        ]),
                )
);


list.add(ItemsCard());


  }
  

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('$name'),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context)
          {

          return Container(

            height: 700,
            child: ListView.builder(


                  itemCount: list.length,
                  itemBuilder: (context, index) => list[index]
    

            

            
              





            )
            
            
            );
        
          },
        );
      },
    );
  }
}
