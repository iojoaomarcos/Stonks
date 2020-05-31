import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
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
  final realController = TextEditingController();
  final dolarController = TextEditingController();

  String _moedaReal = "0.0";
  String _moedaDolar = "0.0";

  double dolar;
  double euro;

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
                            "$_moedaReal Brazilian Real equivale",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 70.0),
                          child: Text(
                            "$_moedaDolar United States Dollar",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 50.0),
                          ),
                        ),
                        buildTextField(
                            "Reais", "R\$", realController, _realChanged),
                        Divider(),
                        buildTextField(
                            "Dólares", "US\$", dolarController, _dolarChanged),
                        Divider(),
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
