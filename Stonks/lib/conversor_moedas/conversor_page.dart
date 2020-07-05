import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:projeto_final_acoes/mercado/carteira_page.dart';
import 'package:projeto_final_acoes/login/login_page.dart';

import 'package:http/http.dart' as http;
import 'package:projeto_final_acoes/conversor_moedas/currencies.dart';
import 'package:projeto_final_acoes/helpers/appSize.dart';
import 'dart:async';
import 'dart:convert';
import 'package:projeto_final_acoes/helpers/firebase_auth.dart';


class ConversorPage extends StatefulWidget {
  @override
  _ConversorPageState createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  //variáveis de inicio
  int _selectedIndex = 0; //indice do bottombar
  String _dropdownValue = 'BRL';
  String _dropdownValue2 = 'USD';
  String _moedaNome = 'Brazilian Real';
  String _moedaNome2 = 'United States Dollar';
  String _moedaSymbol = 'R\$';
  String _moedaSymbol2 = '\$';

  List<String> moedasId = []; //lista dos IDs das moedas

  final moeda1Controller = TextEditingController();
  final moeda2Controller = TextEditingController();

  String _moeda1 = "0.0";
  String _moeda2 = "0.0";

  double dolar;

  @override
  void initState() {
    super.initState();

    DatabaseReference moedasRef =
        FirebaseDatabase.instance.reference().child("Currency");

    moedasRef.once().then((DataSnapshot snap) {
      var key = snap.value.keys;
      var data = snap.value;

      moedasId.clear();

      for (var individualKey in key) {
        Currency currency = new Currency(
          data[individualKey]['currencyName'],
          data[individualKey]['currencySymbol'],
          data[individualKey]['id'],
          individualKey,
        );

        moedasId.add(data[individualKey]['id']);
      }

      setState(() {
        moedasId.sort();
      });
    });
  }

  //função para mudar a moeda escrita em tela
  void _changedMoeda(String newValue, int campo) {
    _clearAll();
    if (campo == 1) {
      DatabaseReference coinRef = FirebaseDatabase.instance
          .reference()
          .child("Currency")
          .child(newValue);

      coinRef.once().then((DataSnapshot snap) {
        var data = snap.value;

        setState(() {
          _dropdownValue = newValue;
          _moedaNome = data['currencyName'];
          _moedaSymbol = data['currencySymbol'];
        });
      });
    } else {
      DatabaseReference coinRef = FirebaseDatabase.instance
          .reference()
          .child("Currency")
          .child(newValue);

      coinRef.once().then((DataSnapshot snap) {
        var data = snap.value;

        setState(() {
          _dropdownValue2 = newValue;
          _moedaNome2 = data['currencyName'];
          _moedaSymbol2 = data['currencySymbol'];
        });
      });
    }
  }

  void _clearAll() {
    moeda1Controller.text = "";
    moeda2Controller.text = "";

    setState(() {
      _moeda1 = "0.0";
      _moeda2 = "0.0";
    });
  }

  Future<Map> getData(request) async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }

  void _moeda1Changed(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    final relation = _dropdownValue + "_" + _dropdownValue2;
    final request = "https://free.currconv.com/api/v7/convert?q=" +
        relation +
        "&compact=ultra&apiKey=b22baa40c5f7f0496958";

    Future<Map> response = getData(request);

    response.then((snap) {
      double coin1 = double.parse(text);
      moeda2Controller.text = (coin1 * snap[relation]).toStringAsFixed(2);

      setState(() {
        _moeda1 = text;
        _moeda2 = (coin1 * snap[relation]).toStringAsFixed(2);
      });
    });
  }

  void _moeda2Changed(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    final relation = _dropdownValue + "_" + _dropdownValue2;
    final request = "https://free.currconv.com/api/v7/convert?q=" +
        relation +
        "&compact=ultra&apiKey=b22baa40c5f7f0496958";

    Future<Map> response = getData(request);

    response.then((snap) {
      double coin2 = double.parse(text);
      moeda1Controller.text = (coin2 / snap[relation]).toStringAsFixed(2);

      setState(() {
        _moeda1 = (coin2 / snap[relation]).toStringAsFixed(2);
        _moeda2 = text;
      });
    });
  }

  //bottomNavigationBar function
  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CarteiraPage()),
      );
    }
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Currency converter",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
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
                style: TextStyle(color: Colors.black, fontSize: setWidth(16.0)),
              ),
              trailing: Icon(
                Icons.attach_money,
                color: Colors.black,
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                "Stocks",
                style: TextStyle(color: Colors.black, fontSize: setWidth(16.0)),
              ),
              trailing: Icon(
                Icons.equalizer,
                color: Colors.black,
              ),
              onTap: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CarteiraPage()),
                );
              }
            ),
            Divider(),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: setWidth(16.0)),
              ),
              trailing: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onTap: (){
                signOut() async {
                  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;    
                  await _firebaseAuth.signOut();
                }
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            ),
            Divider(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(setWidth(10.0)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(setHeight(10.0)),
              child: Text(
                "$_moeda1 $_moedaNome Amounts to",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: setWidth(20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  setWidth(10.0), 0.0, 0.0, setHeight(70.0)),
              child: Text(
                "$_moeda2 $_moedaNome2",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: setWidth(50.0)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: setWidth(20.0)),
              child: Row(
                children: <Widget>[
                  Container(
                    width: setWidth(250.0),
                    child: TextField(
                      controller: moeda1Controller,
                      decoration: InputDecoration(
                        labelText: "$_moedaNome",
                        labelStyle: TextStyle(color: Colors.blueAccent),
                        border: OutlineInputBorder(),
                        prefixText: "$_moedaSymbol",
                      ),
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: setWidth(20.0),
                      ),
                      onChanged: _moeda1Changed,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: setWidth(10.0)),
                    child: DropdownButton<String>(
                      value: _dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: setWidth(24.0),
                      style: TextStyle(
                          color: Colors.black45, fontSize: setWidth(16.0)),
                      underline: Container(
                        height: setWidth(2.0),
                        color: Colors.black45,
                      ),
                      onChanged: (String newValue) {
                        _changedMoeda(newValue, 1);
                      },
                      items: moedasId
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: setWidth(250.0),
                  child: TextField(
                    controller: moeda2Controller,
                    decoration: InputDecoration(
                      labelText: "$_moedaNome2",
                      labelStyle: TextStyle(color: Colors.blueAccent),
                      border: OutlineInputBorder(),
                      prefixText: "$_moedaSymbol2",
                    ),
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: setWidth(20.0),
                    ),
                    onChanged: _moeda2Changed,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: setWidth(10.0)),
                  child: DropdownButton<String>(
                    value: _dropdownValue2,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: setWidth(24.0),
                    style: TextStyle(
                        color: Colors.black45, fontSize: setWidth(16.0)),
                    underline: Container(
                      height: setHeight(2.0),
                      color: Colors.black45,
                    ),
                    onChanged: (String newValue) {
                      _changedMoeda(newValue, 2);
                    },
                    items:
                        moedasId.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[600],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money,
              color: Colors.white,
            ),
            title: Text(
              'Converter',
              style: TextStyle(color: Colors.white, fontSize: setWidth(18.0)),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.equalizer,
              color: Colors.black,
            ),
            title: Text(
              'Stocks',
              style: TextStyle(color: Colors.black, fontSize: setWidth(18.0)),
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
