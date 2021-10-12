import 'dart:async';
import 'dart:convert';

import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void Print(String name) {
  //print(name);
}

class ItemsCard extends StatefulWidget {
  String selectedCoin;

  ItemsCard({
    Key key,
  });

  @override
  _ItemsCardState createState() => _ItemsCardState();
}

class _ItemsCardState extends State<ItemsCard> {
  String selectedCoin;
  BuildContext cont;

  @override
  void initState() {
    super.initState();
    selectedCoin = widget.selectedCoin;

    // DataCallBack = Print;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext c, StateSetter setter) {
      return Container(
        padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
        width: double.maxFinite,
        height: double.maxFinite - 2,
        child: FutureBuilder<List<CryptoData>>(
          future: getCryptoPrices(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                          elevation: 1,
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: Stack(children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                CryptoIcon(),
                                                SizedBox(width: 20),
                                                CryptoNameAbr(
                                                    snapshot.data[index].name,
                                                    snapshot.data[index].symbol,
                                                    Alignment.centerLeft),
                                                Spacer(),
                                                CryptoNameAbr(
                                                    snapshot.data[index].price
                                                        .toStringAsFixed(2),
                                                    snapshot
                                                        .data[index].dayChange
                                                        .toStringAsFixed(2),
                                                    Alignment.centerRight),
                                              ],
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              )
                            ]),
                          )),
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pop(snapshot.data[index]);
                        });
                      },
                    );
                  });
            } else
              return CircularProgressIndicator();
          },
        ),
      );
    });
  }
}

Widget CryptoIcon() {
  return (Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child:
        Align(alignment: Alignment.centerLeft, child: Icon(Icons.tv, size: 25)),
  ));
}

Widget CryptoNameAbr(String name, String abrv, Alignment al) {
  return Align(
    alignment: al,
    child: RichText(
      text: TextSpan(
        text: name,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        children: <TextSpan>[
          TextSpan(
              text: "\n" + abrv,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

class CryptoData {
  String symbol;
  String name;
  int id;
  double price;
  double dayChange;

  CryptoData(
      {@required this.symbol,
      @required this.name,
      @required this.dayChange,
      @required this.price,
      @required this.id});
  factory CryptoData.fromJson(Map<String, dynamic> json) {
    return CryptoData(
        name: json['name'] as String,
        id: json['id'] as int,
        symbol: json['symbol'] as String,
        price: json['quote']['USD']['price'] as double,
        dayChange: json['quote']['USD']['percent_change_24h'] as double);
  }
}

Future<List<CryptoData>> getCryptoPrices() async {
  var response = await http.get(
      Uri.parse(
          "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=20&convert=USD"),
      headers: {
        'X-CMC_PRO_API_KEY': '5ebc8979-1b50-4178-8ab1-e478feee7656',
        "Accept": "application/json",
      });
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);

    var data = body['data'];

    return data.map<CryptoData>((json) => CryptoData.fromJson(json)).toList();
  } else {
    throw "Unable to retrieve posts.";
  }
}
