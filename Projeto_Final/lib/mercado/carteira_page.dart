import 'package:flutter/material.dart';
import 'package:projeto_final_acoes/conversor_moedas/conversor_page.dart';
import 'package:projeto_final_acoes/mercado/buscaAcao_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projeto_final_acoes/mercado/stock.dart';

class CarteiraPage extends StatefulWidget {
  CarteiraPage({Key key}) : super(key: key); ////////Chave para lista Mercado
  @override
  _CarteiraPageState createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  List<Stock> stockList = []; //Lista das acoes do usuario

  Icon _cusIcon = Icon(Icons.search);
  Widget _cusSearchBar = Text("Mercado");

  @override
  void initState() {
    super.initState();
/////////////////////////////////////////////
    DatabaseReference stocksRef =
        FirebaseDatabase.instance.reference().child("u1");

    stocksRef.once().then((DataSnapshot snap) {
      var key = snap.value.keys;
      var data = snap.value;

      stockList.clear();

      for (var individualKey in key) {
        Stock stonks = new Stock(
          data[individualKey]['business'],
          data[individualKey]['stock'],
          individualKey,
        );

        stockList.add(stonks);
      }

      setState(() {
        print('Tamanho da lista de acoes: ' + stockList.length.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _cusSearchBar,
          //centerTitle: true, alinhar para a esquerda e deixar texto em branco
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
                            hintText: "Procurar...",
                            hintStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      );
                    } else {
                      this._cusIcon = Icon(Icons.search);
                      this._cusSearchBar = Text("Mercado");
                    }
                  });
                })
          ],
          elevation: 20.0,
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
            itemCount: stockList.length,
            itemBuilder: (context, index) {
              final item = stockList[index].business;

              return Dismissible(
                key: Key(item), // Chave de identificacao de item
                onDismissed: (direction) {
                  // Se arrastado, remove da lista
                  setState(() {
                    FirebaseDatabase.instance //Remove do Firebase
                        .reference()
                        .child("u1")
                        .child(stockList[index].stockID.toString())
                        .remove();

                    stockList.removeAt(index); //Remove da tela
                  });

                  //Confirmando que item foi removido
                  Scaffold.of(context) //item = item arrastado
                      .showSnackBar(SnackBar(
                          content: Text("$item foi removido da lista")));
                },
                // Quando o item eh arrastado, se mostra uma linha vermelha
                // induzindo o significado de exclusao
                background: Container(color: Colors.red),
                child: ListTile(title: Text('$item')),
              );
            },
          ),

////////////////////////////////////////////////////////////////
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: IconButton(
                    icon: Icon(Icons.attach_money),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => ConversorPage()),
                      );
                    },
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.equalizer),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => CarteiraPage()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
