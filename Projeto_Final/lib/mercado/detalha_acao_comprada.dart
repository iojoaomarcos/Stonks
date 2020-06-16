import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:projeto_final_acoes/helpers/appSize.dart';

class DetalhaAcaoComprada extends StatefulWidget {
  @override
  _DetalhaAcaoCompradaState createState() => _DetalhaAcaoCompradaState();

  final String symbol;
  final String name;
  final int qtde;
  final double priceBuy;
  final double percent;
  final int valFinal;
  final double price;
  final double changePercent;

  const DetalhaAcaoComprada({
    Key key,
    @required this.symbol,
    @required this.name,
    @required this.qtde,
    @required this.priceBuy,
    @required this.percent,
    @required this.valFinal,
    @required this.price,
    @required this.changePercent,
  }) : super(key: key);
}

class _DetalhaAcaoCompradaState extends State<DetalhaAcaoComprada> {
  String name;
  String symbol;
  int qtde;
  double priceBuy;
  double percent;
  int valFinal;
  double price;
  double changePercent;

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
    qtde = widget.qtde;
    priceBuy = widget.priceBuy;
    percent = widget.percent;
    valFinal = widget.valFinal;
    price = widget.price;
    changePercent = widget.changePercent;
  }

  Widget _porcentAcao(price, changePercent) {
    if (changePercent <= 0.0) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: setHeight(8.0)),
            child: Text('R\$ $price',
                style:
                    TextStyle(color: Colors.black, fontSize: setWidth(18.0))),
          ),
          Text('$changePercent%',
              style: TextStyle(color: Colors.red, fontSize: setWidth(18.0)))
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: setHeight(8.0)),
            child: Text('R\$ $price',
                style:
                    TextStyle(color: Colors.black, fontSize: setWidth(18.0))),
          ),
          Text('$changePercent%',
              style: TextStyle(color: Colors.green, fontSize: setWidth(18.0)))
        ],
      );
    }
  }

  Widget _variacaoValorFinal(valFinal, percent) {
    if (percent <= 0.0) {
      return Text('R\$ $valFinal',
          style: TextStyle(color: Colors.red, fontSize: setWidth(18.0)));
    } else {
      return Text('R\$ $valFinal',
          style: TextStyle(color: Colors.green, fontSize: setWidth(18.0)));
    }
  }

  Widget _variacaoPercent(percent) {
    if (percent <= 0.0) {
      return Text('$percent%',
          style: TextStyle(color: Colors.red, fontSize: setWidth(18.0)));
    } else {
      return Text('$percent%',
          style: TextStyle(color: Colors.green, fontSize: setWidth(18.0)));
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
            setWidth(10.0), setHeight(5.0), setWidth(10.0), setHeight(10.0)),
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
              trailing: _porcentAcao(price, changePercent),
            ),
            Divider(
              height: setHeight(5.0),
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(top: setHeight(10.0)),
              child: ListTile(
                title: Text('Quantidade Comprada',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: setWidth(18.0),
                      fontWeight: FontWeight.bold,
                    )),
                trailing: Text('$qtde',
                    style: TextStyle(
                        color: Colors.black, fontSize: setWidth(18.0))),
              ),
            ),
            ListTile(
              title: Text('Preço de Compra',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: setWidth(18.0),
                    fontWeight: FontWeight.bold,
                  )),
              trailing: Text('R\$ $priceBuy',
                  style:
                      TextStyle(color: Colors.black, fontSize: setWidth(18.0))),
            ),
            ListTile(
              title: Text('Variação Comprada (R\$)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: setWidth(18.0),
                    fontWeight: FontWeight.bold,
                  )),
              trailing: _variacaoValorFinal(valFinal, percent),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: setHeight(30.0)),
              child: ListTile(
                title: Text('Variação Comprada (%)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: setWidth(18.0),
                      fontWeight: FontWeight.bold,
                    )),
                trailing: _variacaoPercent(percent),
              ),
            ),
            Container(
              height: setHeight(35.0),
              child: RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {}, //tira posição do banco
                child: Text('Sell',
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
