import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:projeto_final_acoes/mercado/acaoBovespa.dart';
import 'package:projeto_final_acoes/mercado/detalha_inclui_acao.dart';

class BuscaAcaoPage extends StatefulWidget {
  @override
  _BuscaAcaoPageState createState() => _BuscaAcaoPageState();
}

class _BuscaAcaoPageState extends State<BuscaAcaoPage> {
  List<AcaoBovespa> bovespaList = []; //Lista das acoes do usuario

  Icon _cusIcon = Icon(Icons.search);
  Widget _cusSearchBar = Text("Busca Ação");

  @override
  void initState() {
    super.initState();

    DatabaseReference acaoBovespaRef = FirebaseDatabase.instance.reference().child("AcaoBovespa");

    acaoBovespaRef.once().then((DataSnapshot snap) {
      var key  = snap.value.keys;
      var data = snap.value;

      bovespaList.clear();

      for (var individualKey in key) {
        AcaoBovespa acaoBov = new AcaoBovespa(
          data[individualKey]['name'],
          data[individualKey]['symbol'],
          individualKey,
        );

        bovespaList.add(acaoBov);
      }

      setState(() {
        bovespaList.sort();
      });
    });
  }

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
      body: ListView.builder(
        itemCount: bovespaList.length,
        itemBuilder: (context, index){
          final name   = bovespaList[index].name;
          final symbol = bovespaList[index].symbol;

          return Column(
            children: <Widget>[
              ListTile(
                title: Text('$name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '$symbol',
                    style: TextStyle(
                        color: Colors.grey[400], fontSize: 14.0),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhaIncluiAcao(symbol: symbol, name: name)
                    ),
                );}, //Muda para página contendo detalhes da ação passando como parametro o simbolo
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              )
            ],
          );
        }
      ),
    );
  }
}