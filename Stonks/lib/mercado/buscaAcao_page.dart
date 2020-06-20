import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:projeto_final_acoes/helpers/acaoBovespa.dart';
import 'package:projeto_final_acoes/helpers/appSize.dart';
import 'package:projeto_final_acoes/mercado/detalha_inclui_acao.dart';

class BuscaAcaoPage extends StatefulWidget {
  @override
  _BuscaAcaoPageState createState() => _BuscaAcaoPageState();
}

class _BuscaAcaoPageState extends State<BuscaAcaoPage> {
  List<AcaoBovespa> bovespaList = []; //Lista das acoes do usuario

  Icon _cusIcon = Icon(Icons.search);
  Widget _cusSearchBar = Text("Find Stocks");

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
      }

      setState(() {
        bovespaList.sort((a, b) => a.name.compareTo(b.name));
        print('Available stocks amount: ' +
            bovespaList.length.toString());
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
              onPressed: () {
                setState(() {
                  if (this._cusIcon.icon == Icons.search) {
                    this._cusIcon = Icon(Icons.cancel);
                    this._cusSearchBar = TextField(
                      textInputAction: TextInputAction.go,
                      autofocus: true,
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
                    this._cusIcon = Icon(Icons.search);
                    this._cusSearchBar = Text("Find Stocks");
                  }
                });
              })
        ],
        elevation: 20.0,
      ),
      body: ListView.builder(
          itemCount: bovespaList.length,
          itemBuilder: (context, index) {
            final name = bovespaList[index].name;
            final symbol = bovespaList[index].symbol;

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
                    padding: EdgeInsets.only(top: setHeight(8.0)),
                    child: Text(
                      '$symbol',
                      style: TextStyle(
                          color: Colors.grey[400], fontSize: setWidth(14.0)),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetalhaIncluiAcao(symbol: symbol, name: name)),
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
    );
  }
}
