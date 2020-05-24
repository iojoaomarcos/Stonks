import 'package:flutter/material.dart';

class BuscaAcaoPage extends StatefulWidget {
  @override
  _BuscaAcaoPageState createState() => _BuscaAcaoPageState();
}

class _BuscaAcaoPageState extends State<BuscaAcaoPage> {

  Icon _cusIcon = Icon(Icons.search);
  Widget _cusSearchBar = Text("Busca Ação");

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
            onPressed: (){
              setState(() {
                if(this._cusIcon.icon == Icons.search){
                  this._cusIcon = Icon(Icons.cancel);
                  this._cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      hintText: "Procurar...",
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  );
                }
                else{
                  this._cusIcon = Icon(Icons.search);
                  this._cusSearchBar = Text("Busca Ação");
                }
              });
            }
          )
        ],
        elevation: 20.0,
      ),
    );
  }
}