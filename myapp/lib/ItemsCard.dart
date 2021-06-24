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
        width: double.maxFinite,
        height: 800,
        child: FutureBuilder<String>(
          future: getCryptoPrices(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // print(snapshot.data);
              return Text("has data");
            }
            return Text("hasnt data");
          },

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
        ));
  }
}

Widget CryptoIcon() {
  return (Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child:
        Align(alignment: Alignment.centerLeft, child: Icon(Icons.tv, size: 25)),
  ));
}

Widget CryptoNameAbr() {
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

class CryptoData {
  final String currentprice;
  final String name;
  final int id;
  final double price;
  final double dayChange;

  CryptoData(
      {@required this.currentprice,
      @required this.name,
      @required this.dayChange,
      @required this.price,
      @required this.id});
  factory CryptoData.fromJson(Map<String, dynamic> json) {
    return CryptoData(
      name: json["symbol"] as String,
      currentprice: json["price"] as String,
    );
  }
}

// A function that converts a response body into a List<Photo>.
List<CryptoData> parseCryptoData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  //print(parsed);

  return parsed.map<CryptoData>((json) => CryptoData.fromJson(json)).toList();
}

Future<String> getCryptoPrices() async {
  List<CryptoData> list;

  var response = await http.get(
      Uri.parse(
          "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=10&convert=USD"),
      headers: {
        'X-CMC_PRO_API_KEY': '5ebc8979-1b50-4178-8ab1-e478feee7656',
        "Accept": "application/json",
      });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    for (var item in data['data']) {
      print(item['id']);
      print(item['name']);
      print(item['symbol']);
      print(item['quote']['USD']['price']);
      print(item['quote']['USD']['percent_change_24h']);
    }

    // print(coins);
  } else
    print(response.statusCode);
}

class PhotosList extends StatelessWidget {
  final List<CryptoData> prices;

  PhotosList({Key key, @required this.prices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: prices.length,
      itemBuilder: (context, index) {
        String str = prices[index].currentprice +
            "  " +
            prices[index].name +
            prices.length.toString();
        return Text(str);
      },
    );
  }
}
