

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';




const request = "https://api.hgbrasil.com/finance/stock_price?key=2dba2d82&symbol=bidi4";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  
  
}

class _HomeState extends State<Home> {
   //indice do bottombar
  final open3 = TextEditingController();
  final close3 = TextEditingController();

  String open2 = "0.0";
  String close2 = "0.0";
  

  @override
  Widget build(BuildContext context) {
    
    return null;
  }
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    body :  FutureBuilder<Map>(
              future: getData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                        child: Text(
                      "Loading...",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ));
                  default:
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        "Error loading data :( ",
                        style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ));
                    } else {
                      var open3 =snapshot.data["results"]["BIDI4"]["market_time"]["open"];
                      var close3=snapshot.data["results"]["BIDI4"]["market_time"]["close"];
                      var price =snapshot.data["results"]["BIDI4"]["price"];
                      var name = snapshot.data["results"]["BIDI4"]["name"];
                      var region = snapshot.data["results"]["BIDI4"]["region"];
                      var currency = snapshot.data["results"]["BIDI4"]["currency"];
                                     return SingleChildScrollView(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$open3 , horario de abertura",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$close3 , horario de fechamento",
                                                style:TextStyle(color: Colors.grey, fontSize: 20.0)
                                                  
                                              )
                                             )
                                             ,
                                              Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$name , nome",
                                                style:TextStyle(color: Colors.grey, fontSize: 20.0)
                                              )
                                              )
                                              ,Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$region, regiao",
                                                style:TextStyle(color: Colors.grey, fontSize: 20.0)
                                              )   
                                              ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$currency,  ocorrencia",
                                                style:TextStyle(color: Colors.grey, fontSize: 20.0)
                                                  
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$price , valor",
                            style:TextStyle(color: Colors.grey, fontSize: 20.0)
                                           
                              
                          ),
                        ),
                   ],
                ),
          );
      
      }                   
    } 
              }
    )
 );
}
