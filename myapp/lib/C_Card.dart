
import 'package:flutter/material.dart';
import 'ChooseModalBottomSheet.dart';

class C_Card extends StatefulWidget {
  @override
  _C_CardState createState() => _C_CardState();
}

class _C_CardState extends State<C_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
         child: Padding(
        padding: EdgeInsets.only(
        top: 10.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
        title: Text('Conditional Reminder.'),
        children: [
          
          Container(  alignment: Alignment.center,
            child:Padding(padding: EdgeInsets.all(10),child: Text("Condition:", style: TextStyle(fontSize: 20 , color: Colors.green))
          )
          ),

          Padding(padding:EdgeInsets.all(10), child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,    children: <Widget>[

              Text("Coin"),
              ChooseModalBottomSheet(name: "Select Coin: "),
              SizedBox( width: 80 , child: TextField(
             decoration: InputDecoration(
            labelText: 'Value:')
          //autofocus: true,
              )),
      
      
          ]

          
          
          
          )
          ),

          Container(  alignment: Alignment.center,
            child:Padding(padding: EdgeInsets.all(10),child: Text("Action:", style: TextStyle(fontSize: 22 , color: Colors.green))
          )
          ),
         Padding(padding: EdgeInsets.all(10),  child: ChooseModalBottomSheet(name: "Select Action")),


        ],
        
      ),
    ),
      
    );
  }
}