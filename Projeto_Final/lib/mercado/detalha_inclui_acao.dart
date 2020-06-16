import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:projeto_final_acoes/helpers/appSize.dart';

class DetalhaIncluiAcao extends StatefulWidget {
  @override
  _DetalhaIncluiAcaoState createState() => _DetalhaIncluiAcaoState();

  final String symbol;
  final String name;

  const DetalhaIncluiAcao({
    Key key,
    @required this.symbol,
    @required this.name,
  }) : super(key: key);
}

class _DetalhaIncluiAcaoState extends State<DetalhaIncluiAcao> {
  final qtdeController = TextEditingController();
  final priceController = TextEditingController();

  String name;
  String symbol;

  String region = '';
  String currency = '';
  double price = 0.0;
  double changePercent = 0.0;

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
    name = widget.name;
    symbol = widget.symbol;

    final request =
        "https://api.hgbrasil.com/finance/stock_price?key=23cf857d&symbol=" +
            symbol;

    Future<Map> response = getData(request);

    response.then((snap) {
      setState(() {
        region = snap['results'][symbol]['region'];
        currency = snap['results'][symbol]['currency'];
        price = snap['results'][symbol]['price'];
        changePercent = snap['results'][symbol]['change_percent'];

        priceController.text =
            snap['results'][symbol]['price'].toStringAsFixed(2);
      });
    });
  }

  Future<Map> getData(request) async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }

  Widget _porcentagem(price, percent) {
    if (percent <= 0.0) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: setHeight(8.0)),
            child: Text('$price',
                style:
                    TextStyle(color: Colors.black, fontSize: setWidth(18.0))),
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
            child: Text('$price',
                style:
                    TextStyle(color: Colors.black, fontSize: setWidth(18.0))),
          ),
          Text('$percent%',
              style: TextStyle(color: Colors.green, fontSize: setWidth(18.0)))
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 20.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
            setWidth(10.0), setHeight(10.0), setWidth(10.0), setHeight(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text('$name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: setWidth(18.0),
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Padding(
                padding: EdgeInsets.only(top: setHeight(8.0)),
                child: Text(
                  '$symbol',
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: setWidth(14.0)),
                ),
              ),
              trailing: _porcentagem(price, changePercent),
            ),
            Divider(
              height: setHeight(5.0),
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: setHeight(30.0), bottom: setHeight(10.0)),
              child: TextField(
                controller: qtdeController,
                decoration: InputDecoration(
                  labelText: "Qtd.",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  hintText: "ex.: 100",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: setWidth(18.0),
                ),
                onSubmitted: (value) {
                  qtdeController.text = value;
                },
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: setHeight(15.0), bottom: setHeight(60.0)),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "Price",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: setWidth(18.0),
                ),
                onSubmitted: (value) {
                  qtdeController.text = value;
                },
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              height: setHeight(35.0),
              child: RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {}, //grava posição no banco
                child: Text('Add Purchase',
                    style: TextStyle(
                        color: Colors.white, fontSize: setWidth(20.0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//teste