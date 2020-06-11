import 'dart:html';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:projeto_final_acoes/conversor_moedas/conversor_page.dart';


const request = "https://api.hgbrasil.com/finance/stoc_rpice?key35fb37b4&symbol=bidi4.petr4.qual3.ciel3";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  
  
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; //indice do bottombar
  final open = TextEditingController();
  final close = TextEditingController();
  
  String open2 = "0.0";
  String close2 = "0.0";
  
 

  
  

  void _clearAll() {
    open.text = "";
    close.text = "";
    

    setState(() {
      open2 = "0.0";
      close2 = "0.0";
      
    });
  }

  void _open(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    close.text= close.toString();
    open.text = open.toString();
  
    setState(() {
      open2 = text;
      open2 = (open2.toString());
    });
  }

  void _close(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double dolar = double.parse(text);
    open.text = (open.toString());

    setState(() {
      open2= (open2.toString());
      open2 = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  

  
  
  
}




  @override
  Widget build(BuildContext context) {
    
    Body :  FutureBuilder<Map>(
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
                      var open3 =snapshot.data["results"]["BIDI4"]["open"];
                      var close3=snapshot.data["results"]["BIDI4"]["close"];
                    return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "$open3 ",
                          style:
                                TextStyle(color: Colors.grey, fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "$close3 ",
                            style:TextStyle(color: Colors.grey, fontSize: 20.0)
                              
                          ),
                        ),
                   ],
                ),
          );
      
      }                   
 } 
};