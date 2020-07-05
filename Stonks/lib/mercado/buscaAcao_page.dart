import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';
import 'package:projeto_final_acoes/helpers/acaoBovespa.dart';
import 'package:projeto_final_acoes/helpers/appSize.dart';
import 'package:projeto_final_acoes/mercado/detalha_inclui_acao.dart';

const request =
    "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-high";
const request2 =
    "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-low";

Future<Map> getData() async {
  var requestFocusAction = RequestFocusAction;
  http.Response response = await http.get(requestFocusAction);
  return json.decode(response.body);
}

class BuscaAcaoPage extends StatefulWidget {
  @override
  _BuscaAcaoPageState createState() => _BuscaAcaoPageState();
  get _focusNode2 =>
      "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-low";

  get _focusNode =>
      "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-high";
}

class _BuscaAcaoPageState extends State<BuscaAcaoPage> {
  List<AcaoBovespa> bovespaList = []; //Lista das acoes do usuario
  List<AcaoBovespa> bovespashown = []; //Lista de acoes exibidas na tela

  Icon _cusIcon = Icon(Icons.search);
  Widget _cusSearchBar =
      Text("Find Stocks", style: TextStyle(color: Colors.white));

  get _focusNode =>
      "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-high";
  get _focusNode2 =>
      "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=get-low";
  var symbol;

  //Responsive APP
  double setWidth(double value) {
    return value * AppSize.widthProportions(MediaQuery.of(context).size.width);
  }

  double setHeight(double value) {
    return value *
        AppSize.heightProportions(MediaQuery.of(context).size.height);
  }

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

    @override
    void initState() {
      super.initState();

      DatabaseReference acaoBovespaRef =
          FirebaseDatabase.instance.reference().child("AcaoBovespa");

      acaoBovespaRef.once().then((DataSnapshot snap) {
        var key = snap.value.keys;
        var data = snap.value;

        bovespaList.clear();

        for (var individualKey in key) {
          AcaoBovespa acaoBov = new AcaoBovespa(
            data[individualKey]['name'],
            data[individualKey]['symbol'],
            individualKey,
          );

          bovespaList.add(acaoBov);
          bovespashown.add(acaoBov);
        }

        setState(() {
          bovespaList.sort((a, b) => a.name.compareTo(b.name));
          bovespashown.sort((a, b) => a.name.compareTo(b.name));
          print('Available stocks amount: ' + bovespaList.length.toString());
        });
      });
    }

    void filterSearchResults(String query) {
      List<AcaoBovespa> filteredList = [];
      filteredList.addAll(bovespaList);
      if (query.isNotEmpty) {
        List<AcaoBovespa> tempList = [];
        filteredList.forEach((item) {
          if (item.name.toLowerCase().contains(query.toLowerCase()) ||
              item.symbol.toLowerCase().contains(query.toLowerCase())) {
            tempList.add(item);
          }
        });
        setState(() {
          bovespashown.clear();
          bovespashown.addAll(tempList);
        });
        return;
      } else {
        setState(() {
          bovespashown.clear();
          bovespashown.addAll(bovespaList);
        });
      }
    }

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
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: _cusSearchBar,
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            actions: <Widget>[
              IconButton(
                  icon: _cusIcon,
                  onPressed: () {
                    setState(() {
                      if (this._cusIcon.icon == Icons.search) {
                        this._cusIcon = Icon(Icons.cancel);
                        this._cusSearchBar = TextField(
                          textInputAction: TextInputAction.go,
                          autofocus: true,
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: "Search ...",
                          ),
                          style: TextStyle(
                              color: Colors.white, fontSize: setWidth(16.0)),
                        );
                      } else {
                        filterSearchResults('');
                        this._cusIcon = Icon(Icons.search);
                        this._cusSearchBar = Text("Find Stocks",
                            style: TextStyle(color: Colors.white));
                      }
                    });
                  })
            ],
            elevation: 20.0,
          ),
          body: FutureBuilder<Map>(
              future: getData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                        child: Text(
                      "Loading...",
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 20.0),
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
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$nome, nome",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$regiao, regiao",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$ocorrencia, ocorrencia",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$open, abaertura",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$close, fecha",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$cap, cap",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$preco, preco",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$timezone, tempo",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$porcentagem, porcentagem",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "$atualizacao, atualizacao",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: bovespashown.length,
                                  itemBuilder: (context, index) {
                                    final name = bovespashown[index].name;
                                    final symbol = bovespashown[index].symbol;

                                    return Column(
                                      children: <Widget>[
                                        ListTile(
                                          title: Text('$name',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: setWidth(20.0),
                                                fontWeight: FontWeight.bold,
                                              )),
                                          subtitle: Padding(
                                            padding: EdgeInsets.only(
                                                top: setHeight(8.0)),
                                            child: Text(
                                              '$symbol',
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: setWidth(14.0)),
                                            ),
                                          ),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetalhaIncluiAcao(
                                                          symbol: symbol,
                                                          name: name)),
                                            );
                                          }, //Muda para página contendo detalhes da ação passando como parametro o simbolo
                                        ),
                                        Divider(
                                          height: setHeight(2.0),
                                          color: Colors.grey,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    }
                }
              }));
    }
  }
}
