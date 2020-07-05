import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:projeto_final_acoes/conversor_moedas/conversor_page.dart';
import 'package:projeto_final_acoes/login/login_page.dart';

import 'package:projeto_final_acoes/helpers/appSize.dart';
import 'package:projeto_final_acoes/mercado/buscaAcao_page.dart';
import 'package:projeto_final_acoes/mercado/detalha_acao_comprada.dart';
import 'package:projeto_final_acoes/helpers/stock.dart';
import 'package:projeto_final_acoes/UserData.dart' as globals;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CarteiraPage extends StatefulWidget {
  CarteiraPage({Key key}) : super(key: key); //Chave para lista Carteira
  @override
  _CarteiraPageState createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  int _selectedIndex = 1; //indice do bottombar
  List<Stock> stockList = []; //Lista das acoes do usuario
  List<Stock> stockshown = []; //Lista a ser exibida ao usuario

  Icon _cusIcon = Icon(Icons.search);
  Widget _cusSearchBar = Text(
    "Stocks",
    style: TextStyle(
      color: Colors.white,
    ),
  );

  //Responsive APP
  double setWidth(double value) {
    return value * AppSize.widthProportions(MediaQuery.of(context).size.width);
  }

  double setHeight(double value) {
    return value *
        AppSize.heightProportions(MediaQuery.of(context).size.height);
  }

  @override
  void initState() {
    super.initState();

    print('The user has the following id: ' + globals.userID);

    FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(globals.userID)
        .child('login')
        .set({"user": globals.userID});

    DatabaseReference stocksRef = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(globals.userID.toString());

    FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(globals.userID)
        .child('login')
        .remove();

    stocksRef.once().then((DataSnapshot snap) {
      var key = snap.value.keys;
      var data = snap.value;

      stockList.clear();

      for (var individualKey in key) {
        final request =
            "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=" +
                data[individualKey]['symbol'];

        Future<Map> response = getData(request);

        response.then((snap) {
          double price =
              snap['results'][data[individualKey]['symbol']]['price'];
          double changePercent =
              snap['results'][data[individualKey]['symbol']]['change_percent'];

          var percent = double.parse(
              (((price / data[individualKey]['priceBuy']) - 1) * 100)
                  .toStringAsFixed(1));
          var valFinal = ((data[individualKey]['priceBuy'] - price) *
                  data[individualKey]['qtde'])
              .round();

          Stock stonks = new Stock(
            data[individualKey]['name'],
            data[individualKey]['symbol'],
            data[individualKey]['qtde'],
            data[individualKey]['priceBuy'],
            percent,
            valFinal,
            price,
            changePercent,
            individualKey,
          );

          setState(() {
            stockList.add(stonks);
            stockshown.add(stonks);
          });
        });
      }
    });
  }

  Widget _porcentagem(percent, valFinal, qtde) {
    if (percent <= 0.0) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: setHeight(8.0)),
            child: Text('R\$ $valFinal',
                style: TextStyle(color: Colors.red, fontSize: setWidth(18.0))),
          ),
          Text('$percent%',
              style: TextStyle(color: Colors.red, fontSize: setWidth(18.0)))
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('R\$ $valFinal',
                style:
                    TextStyle(color: Colors.green, fontSize: setWidth(18.0))),
          ),
          Text('$percent%',
              style: TextStyle(color: Colors.green, fontSize: setWidth(18.0)))
        ],
      );
    }
  }

  Future<Map> getData(request) async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ConversorPage()),
      );
    }
  }

  void filterSearchResults(String query) {
    List<Stock> filteredList = [];
    filteredList.addAll(stockList);
    if (query.isNotEmpty) {
      List<Stock> tempList = [];
      filteredList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.symbol.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item);
        }
      });
      setState(() {
        stockshown.clear();
        stockshown.addAll(tempList);
      });
      return;
    } else {
      setState(() {
        stockshown.clear();
        stockshown.addAll(stockList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _cusSearchBar,
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
                            hintStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(
                            color: Colors.white, fontSize: setWidth(16.0)),
                      );
                    } else {
                      filterSearchResults('');
                      this._cusIcon = Icon(Icons.search);
                      this._cusSearchBar =
                          Text("Stocks", style: TextStyle(color: Colors.white));
                    }
                  });
                })
          ],
          elevation: 20.0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Exemplo"),
                accountEmail: Text("exemplo@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("E"),
                ),
              ),
              ListTile(
                title: Text(
                  "Converter",
                  style:
                      TextStyle(color: Colors.black, fontSize: setWidth(16.0)),
                ),
                trailing: Icon(
                  Icons.attach_money,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ConversorPage()),
                  );
                },
              ),
              Divider(),
              ListTile(
                  title: Text(
                    "Stocks",
                    style: TextStyle(
                        color: Colors.black, fontSize: setWidth(16.0)),
                  ),
                  trailing: Icon(
                    Icons.equalizer,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              Divider(),
              ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.black, fontSize: setWidth(16.0)),
                  ),
                  trailing: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  onTap: () {
                    signOut() async {
                      globals.googleSignIn.signOut();
                      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                      await _firebaseAuth.signOut();
                    }

                    signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }),
              Divider(),
            ],
          ),
        ),
        body: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BuscaAcaoPage()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blueAccent,
          ),
          body: ListView.builder(
            itemCount: stockshown.length,
            itemBuilder: (context, index) {
              final item = stockshown[index].name;
              final symbol = stockshown[index].symbol;
              final qtde = stockshown[index].qtde;
              final priceBuy = stockshown[index].priceBuy;
              final percent = stockshown[index].percent;
              final valFinal = stockshown[index].valFinal;
              final price = stockshown[index].price;
              final changePercent = stockshown[index].changePercent;

              return Dismissible(
                key: Key(item), // Chave de identificacao de item
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  // Se arrastado, remove da lista
                  setState(() {
                    FirebaseDatabase.instance //Remove do Firebase
                        .reference()
                        .child("users")
                        .child(globals.userID.toString())
                        .child(stockList[index].stockID.toString())
                        .remove();

                    stockList.removeAt(index); //Remove da tela
                    filterSearchResults('');
                  });

                  //Confirmando que item foi removido
                  Scaffold.of(context) //item = item arrastado
                      .showSnackBar(
                          SnackBar(content: Text("$item Removed from list")));
                },
                // Quando o item eh arrastado, se mostra uma linha vermelha
                // induzindo o significado de exclusao
                background: Container(
                  // Quando o item é arrastado mostra uma linha vermelha, induzindo o significado de exclusão
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment(-0.9, 0.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),

                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('$item',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: setWidth(20.0),
                            fontWeight: FontWeight.bold,
                          )),

                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: setHeight(10.0), bottom: setHeight(5.0)),
                              child: Text(
                                '$symbol',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: setWidth(16.0)),
                              ),
                            ),
                            Text('Qtd. Buy: $qtde',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: setWidth(16.0)))
                          ]),
                      isThreeLine: true,
                      trailing: _porcentagem(percent, valFinal, qtde),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetalhaAcaoComprada(
                                  symbol: symbol,
                                  name: item,
                                  qtde: qtde,
                                  priceBuy: priceBuy,
                                  percent: percent,
                                  valFinal: valFinal,
                                  price: price,
                                  changePercent: changePercent)),
                        );
                      }, //Muda para página contendo detalhes da ação passando como parametro o simbolo
                    ),
                    Divider(
                      height: setHeight(2.0),
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue[600],
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.attach_money,
                  color: Colors.black,
                ),
                title: Text(
                  'Converter',
                  style:
                      TextStyle(color: Colors.black, fontSize: setWidth(18.0)),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.equalizer,
                  color: Colors.white,
                ),
                title: Text(
                  'Stocks',
                  style:
                      TextStyle(color: Colors.white, fontSize: setWidth(18.0)),
                ),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ));
  }
}
