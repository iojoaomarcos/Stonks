



import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';


const request = "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-high";
const request2= "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-low";

Future<Map> getData() async {
  var requestFocusAction = RequestFocusAction;
    http.Response response = await http.get(requestFocusAction);
  return json.decode(response.body);
}
  
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  
  
}

class _HomeState extends State<Home> 
   {
var symbol;
var press;
     get _focusNode2 => "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-low";

     get _focusNode => "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-high";

  

  
  @override
  Widget build(BuildContext context) {
    
        String _textoString= symbol;
                      return Column(
                        children: <Widget>[
                          Text(_textoString, style: TextStyle(fontSize: 30),
               ),
               RaisedButton(
                 child: Text('altas'), onPressed: () {
                   press = 1;
                   Actions.invoke(context, const Intent(RequestFocusAction.key), focusNode: _focusNode);
                 }
               ),RaisedButton(
                 child: Text('baixas'), onPressed: () {
                   press=2;
                   Actions.invoke(context, const Intent(RequestFocusAction.key), focusNode: _focusNode2);
                 }
                        ),

                        ]
                      );


var simbolo; 
var nome;
var regiao;
var ocorrencia;
var open;
var close;
var timezone;
var cap;
var preco;
var porcentagem;
var atualizacao;


  


         
    Scaffold(
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
                       simbolo = snapshot.data["results"]["symbol"];
                        nome =snapshot.data["results"]["name"];
                         regiao = snapshot.data["results"]["region"];
                       ocorrencia =snapshot.data["results"]["currency"];
                       open =snapshot.data["results"]["market_time"]["open"];
                       close =snapshot.data["results"]["market_time"]["close"];
                       timezone =snapshot.data["results"]["market_time"]["timezone"];
                       cap =snapshot.data["results"]["market_cap"];
                       preco =snapshot.data["results"]["price"];
                       porcentagem =snapshot.data["results"]["change_percent"];
                       atualizacao =snapshot.data["results"]["updated_at"];


                                     return SingleChildScrollView(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$simbolo, sigla",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$nome, nome",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$regiao, regiao",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$ocorrencia, ocorrencia",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$open, abaertura",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$close, fecha",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$cap, cap",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$preco, preço",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$timezone, tempo",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$porcentagem, porcentagem",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
                                              ),
                                            ),Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "$atualizacao, atualizacao",
                                              style:
                                                    TextStyle(color: Colors.grey, fontSize: 20.0),
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
  }





 
