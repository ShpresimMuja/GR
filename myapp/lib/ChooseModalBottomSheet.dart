import 'package:flutter/material.dart';



class ChooseModalBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  TextButton(
                        child: const Text('showModalBottomSheet'),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 800,
                                color: Colors.white,
                                child: Padding( padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                    
                                    Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: [ TextButton(child: Text("Press", style: TextStyle( fontSize: 20,  color: Colors.blue, fontWeight: FontWeight.bold),),),
                                    IconButton(icon: const Icon(Icons.close), onPressed: ()=> Navigator.pop(context))] )
                                      
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