import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:projeto_final_acoes/conversor_moedas/currencies.dart';
import 'dart:async';
import 'dart:convert';

import 'package:projeto_final_acoes/mercado/carteira_page.dart';

const request = "https://api.hgbrasil.com/finance?format=json&key=49e7344b";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class ConversorPage extends StatefulWidget {
  @override
  _ConversorPageState createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  int _selectedIndex = 0; //indice do bottombar

  List<Currency> currencyList = [];
  List<String> moedasCod = [];

  final realController = TextEditingController();
  final dolarController = TextEditingController();

  String _moedaReal = "0.0";
  String _moedaDolar = "0.0";

  double dolar;
  double euro;

  String dropdownValue = 'BRL';
  String dropdownValue2 = 'Dolar';

  @override
  void initState() {
    super.initState();

    DatabaseReference stocksRef =
        FirebaseDatabase.instance.reference().child("Currency");

    stocksRef.once().then((DataSnapshot snap) {
      var key = snap.value.keys;
      var data = snap.value;

      currencyList.clear();

      for (var individualKey in key) {
        Currency stonks = new Currency(
          data[individualKey]['COD'],
          data[individualKey]['Nome'],
          individualKey,
        );

        currencyList.add(stonks);
        moedasCod.add(data[individualKey]['COD']);
        /////////////////////////////////////////////////////////////////////////////
      }

      setState(() {
        print('Tamanho da lista de moedas: ' + currencyList.length.toString());
      });
    });
  }

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";

    setState(() {
      _moedaReal = "0.0";
      _moedaDolar = "0.0";
    });
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);

    setState(() {
      _moedaReal = text;
      _moedaDolar = (real / dolar).toStringAsFixed(2);
    });
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);

    setState(() {
      _moedaReal = (dolar * this.dolar).toStringAsFixed(2);
      _moedaDolar = text;
    });
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CarteiraPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Conversor de Moedas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
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
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "$_moedaReal Reais Brasileiros equivalem a",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 70.0),
                          child: Text(
                            "$_moedaDolar Dolares Americanos",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 50.0),
                          ),
                        ),
                        buildTextField(
                            "Reais", "R\$", realController, _realChanged),
                        Divider(),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black45),
                          underline: Container(
                            height: 2,
                            color: Colors.black45,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: moedasCod
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        buildTextField(
                            "Dólares", "US\$", dolarController, _dolarChanged),
                        Divider(),
                        DropdownButton<String>(
                          value: dropdownValue2,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black45),
                          underline: Container(
                            height: 2,
                            color: Colors.black45,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['Real', 'Dolar', 'Euro', 'Bitcoin']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[600],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money,
              color: Colors.white,
            ),
            title: Text(
              'Conversor',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.equalizer,
              color: Colors.black,
            ),
            title: Text(
              'Carteira',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.blueAccent),
      border: OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}
