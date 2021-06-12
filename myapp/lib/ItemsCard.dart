import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class ItemsCard extends StatefulWidget {
  @override
  _ItemsCardState createState() => _ItemsCardState();
}

class _ItemsCardState extends State<ItemsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
      height: 80,
      width: double.maxFinite,
      child: FutureBuilder(

          future: fetchAlbum(),
          builder: (BuildContext context, AsyncSnapshot<CryptoData> snapshot)
          {
              if(snapshot.hasData)
              {

                  CryptoData CD = snapshot.data;

                  return ListView(children: [


                    Text(CD.currentprice.toString()),
                    Text(CD.name.toString()),




                   




                  ],);
              }
                    return Center(child: CircularProgressIndicator());

              }
             



    


      ),
      
      
      
      
      /* Card(
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CryptoIcon(),

                                SizedBox(
                                  width: 20
                                ),

                                CryptoNameAbr(),


                              ],
                            )
                          ],
                        ))
                  ],
                ),
              )
            ]),
          )),
        */

        

        
    );
  }
}

Widget CryptoIcon() {
  return (Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Align(
        alignment: Alignment.centerLeft,
        child: Icon( Icons.tv,
          size: 25
        )),
  ));
}

Widget CryptoNameAbr()
{   
   return Align(
     alignment: Alignment.centerLeft,
     child: RichText(
       text: TextSpan(
         text: "Bitcoin",
         style: TextStyle(
             fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
         children: <TextSpan>[
           TextSpan(
               text: "\nBTC",
               style: TextStyle(
                   color: Colors.grey,
                   fontSize: 15,
                   fontWeight: FontWeight.bold)),
         ],
       ),
     ),
   );





}


class CryptoData
{
    final double currentprice;
    final double dayChange;
    final String name;
    final String abrv;


    CryptoData({
      @required this.currentprice,
      @required this.dayChange, 
      @required this.name,
      @required this.abrv

    });
    factory CryptoData.fromJson(Map<String, dynamic> json)
    {

        return CryptoData(


            currentprice: json["price"],
            dayChange: 0,
            name:     json["symbol"],
            abrv:    "Eth"



        );






    }






}



Future<CryptoData> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://api.binance.com/api/v3/ticker/price?symbol=ETHBTC'),
      
      headers: {
        HttpHeaders.authorizationHeader: "eZb84pbHeqmBLPLhoBv3tap78DZUhC964YQXfR4KvRxntphwQl1kaFeBErzOJ9kQ"
      }
      
      
      
    );
    print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CryptoData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
  //  throw Exception('Failed to load album');
  }
}