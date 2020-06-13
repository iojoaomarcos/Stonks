



import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



const request = "https://api.hgbrasil.com/finance/stock_price?key=2dba2d82&symbol=bidi4";
const request2 = "https://api.hgbrasil.com/finance/stock_price?key=2dba2d82&symbol=petr4";
const request3 = "https://api.hgbrasil.com/finance/stock_price?key=2dba2d82&symbol=qual3";
const request4 = "https://api.hgbrasil.com/finance/stock_price?key=2dba2d82&symbol=ciel3";

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
  var acao;

  

  String get $acao => null;

  get _focusNode2 => "https://api.hgbrasil.com/finance/stock_price?key=2dba2d82&symbol=petr4";

  get _focusNode => "https://api.hgbrasil.com/finance/stock_price?key=2dba2d82&symbol=bidi4";

  get _focusNode3 => "https://api.hgbrasil.com/finance/stock_price?key=2dba2d82&symbol=qual3";

  get _focusNode4 => "https://api.hgbrasil.com/finance/stock_price?key=2dba2d82&symbol=ciel3";

  set open3(open3) {}

  

         @override
         Widget build(BuildContext context) {
           String _textoString= $acao;
                      return Column(
                        children: <Widget>[
                          Text(_textoString, style: TextStyle(fontSize: 30),
               ),
               RaisedButton(
                 child: Text('Banco Inter S.A.'), onPressed: () {
                   acao="BIDI4";
                   Actions.invoke(context, const Intent(RequestFocusAction.key), focusNode: _focusNode);
                 }
               ),RaisedButton(
                 child: Text('Petrobras'), onPressed: () {
                   acao="PETR4";
                   Actions.invoke(context, const Intent(RequestFocusAction.key), focusNode: _focusNode2);
                 }
               ),RaisedButton(
                 child: Text('Qualicorp Consultoria e Corretora de Seguros S.A.'), onPressed: () {
                   acao="QUAL3";
                   Actions.invoke(context, const Intent(RequestFocusAction.key), focusNode: _focusNode3);
                 }
               ),RaisedButton(
                 child: Text('Cielo'), onPressed: () {
                   acao="CIEL3";
                   Actions.invoke(context, const Intent(RequestFocusAction.key), focusNode: _focusNode4);
                 }
               ),
             ],
           );
  
   //indice do bottombar
  var open3 = TextEditingController();
  var close3 = TextEditingController(); 
   var price = TextEditingController();
  var name= TextEditingController();  
  var region = TextEditingController();
  var currency = TextEditingController();

  

  
   
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
                       open3 =snapshot.data["results"][$acao]["market_time"]["open"];
                       close3=snapshot.data["results"][$acao]["market_time"]["close"];
                       price =snapshot.data["results"][$acao]["price"];
                       name = snapshot.data["results"][$acao]["name"];
                      region = snapshot.data["results"][$acao]["region"];
                      currency = snapshot.data["results"][$acao]["currency"];
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
}
 
