import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';
import 'package:projeto_final_acoes/helpers/acaoBovespa.dart';
import 'package:projeto_final_acoes/helpers/appSize.dart';
import 'package:projeto_final_acoes/mercado/detalha_inclui_acao.dart';

const request =
    "https://api.hgbrasil.com/finance/stock_price?key=9b96250e&symbol=get-high";
const request2 =
    "https://api.hgbrasil.com/finance/stock_price?key=9b96250e&symbol=get-low";

Future<Map> getData() async {
  var requestFocusAction = RequestFocusAction;
  http.Response response = await http.get(requestFocusAction);
  return json.decode(response.body);
}

class BuscaAcaoPage extends StatefulWidget {
  @override
  _BuscaAcaoPageState createState() => _BuscaAcaoPageState();
}

class _BuscaAcaoPageState extends State<BuscaAcaoPage> {
  get _focusNode =>
      "https://api.hgbrasil.com/finance/stock_price?key=9b96250e&symbol=get-high";

  get _focusNode2 =>
      "https://api.hgbrasil.com/finance/stock_price?key=9b96250e&symbol=get-low";

  var symbol;

  //Responsive APP

  @override
  Widget build(BuildContext context) {
    String _textoString = symbol;
    return Column(children: <Widget>[
      Text(
        _textoString,
        style: TextStyle(fontSize: 30),
      ),
      RaisedButton(
          child: Text('altas'),
          onPressed: () {
            Actions.invoke(context, const Intent(RequestFocusAction.key),
                focusNode: _focusNode);
          }),
      RaisedButton(
          child: Text('baixas'),
          onPressed: () {
            Actions.invoke(context, const Intent(RequestFocusAction.key),
                focusNode: _focusNode2);
          }),
    ]);

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
        body: FutureBuilder<Map>(
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
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    simbolo = snapshot.data["results"]["symbol"];
                    nome = snapshot.data["results"]["name"];
                    regiao = snapshot.data["results"]["region"];
                    ocorrencia = snapshot.data["results"]["currency"];
                    open = snapshot.data["results"]["market_time"]["open"];
                    close = snapshot.data["results"]["market_time"]["close"];
                    timezone =
                        snapshot.data["results"]["market_time"]["timezone"];
                    cap = snapshot.data["results"]["market_cap"];
                    preco = snapshot.data["results"]["market_cap"]["price"];
                    porcentagem = snapshot.data["results"]["market_cap"]
                        ["change_percent"];
                    atualizacao =
                        snapshot.data["results"]["market_cap"]["updated_at"];

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
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "$nome, nome",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "$regiao, regiao",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "$ocorrencia, ocorrencia",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "$open, abaertura",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "$close, fecha",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "$cap, cap",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "$preco, preco",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "$timezone, tempo",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "$porcentagem, porcentagem",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0),
                            ),
                          ),
                          Padding(
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
            }));
  }
}
