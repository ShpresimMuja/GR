
import 'package:flutter/material.dart';
import 'ChooseModalBottomSheet.dart';
class C_AppBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
                appBar: AppBar(
          title: Center(child: Text("ConReminder")),
          backgroundColor: Colors.lightBlue,
          
          
          ),
          drawer:Drawer(
  
    child: ListView(
    
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Preferences', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            
          ),
        ),
        ListTile(
          title: Text('About', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
          onTap: () {
            
          },
        ),
      ],
    ),
  ),

  body: Container(
    child: Padding(
    padding: EdgeInsets.only(
        top: 10.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
        title: Text('Conditional Reminder.'),
        children: [
          
          Container(  alignment: Alignment.centerLeft,
            child:Padding(padding: EdgeInsets.all(10),child: Text("Condition:", style: TextStyle(fontSize: 23 , color: Colors.green))
          )
          ),

          Padding(padding:EdgeInsets.all(10), child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,    children: <Widget>[

              Text("Coin"),
              ChooseModalBottomSheet(),
              Text("Reaches"),
              SizedBox( width: 80 , child: TextField(
             decoration: InputDecoration(
             border: OutlineInputBorder(),
            labelText: 'Value:')
          //autofocus: true,
              )),
      
      
          ]

          
          
          
          )
          ),

          Container(  alignment: Alignment.centerLeft,
            child:Padding(padding: EdgeInsets.all(10),child: Text("Action:", style: TextStyle(fontSize: 23 , color: Colors.green))
          )
          ),
         Padding(padding: EdgeInsets.all(10),  child: ChooseModalBottomSheet()),


        ],
        
      ),
    ),
  ),

    
    );
  }

}








