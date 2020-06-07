import 'package:flutter/material.dart';
import 'package:projeto_final_acoes/conversor_moedas/conversor_page.dart';
import 'package:projeto_final_acoes/mercado/buscaAcao_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projeto_final_acoes/mercado/stock.dart';
import 'package:projeto_final_acoes/UserData.dart' as globals;

class CarteiraPage extends StatefulWidget {
  CarteiraPage({Key key}) : super(key: key); ////////Chave para lista Carteira
  @override
  _CarteiraPageState createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  int _selectedIndex = 1; //indice do bottombar
  List<Stock> stockList = []; //Lista das acoes do usuario

  Icon _cusIcon = Icon(Icons.search);
  Widget _cusSearchBar = Text(
    "Carteiras",
    style: TextStyle(
      color: Colors.white,
    ),
  );

  @override
  void initState() {
    super.initState();

    print('O usuario atual tem o seguinte ID: ' + globals.userID);

    DatabaseReference stocksRef =
        FirebaseDatabase.instance.reference().child("users").child("u3");

    stocksRef.once().then((DataSnapshot snap) {
      var key = snap.value.keys;
      var data = snap.value;

      stockList.clear();

      for (var individualKey in key) {
        Stock stonks = new Stock(
          data[individualKey]['business'],
          data[individualKey]['percentage'],
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

  Widget _porcentagem(percent) {
    if (percent.substring(0, 1) == '-') {
      return Text('$percent%',
          style: TextStyle(color: Colors.red, fontSize: 18.0));
    } else {
      return Text('$percent%',
          style: TextStyle(color: Colors.green, fontSize: 18.0));
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ConversorPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _cusSearchBar,
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
                      this._cusSearchBar = Text("Carteiras");
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
              final subtitle = stockList[index].stock;
              final percent = stockList[index].percentage;

              return Dismissible(
                key: Key(item), // Chave de identificacao de item
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  // Se arrastado, remove da lista
                  setState(() {
                    FirebaseDatabase.instance //Remove do Firebase
                        .reference()
                        .child("users")
                        .child("u3")
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
                background: Container(
                  // Quando o item é arrastado mostra uma linha vermelha, induzindo o significado de exclusão
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment(-0.9, 0.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                //child: ListTile(title: Text('$item')),

                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('$item',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '$subtitle',
                          style: TextStyle(
                              color: Colors.grey[400], fontSize: 14.0),
                        ),
                      ),
                      trailing: _porcentagem(percent),
                      onTap: () {}, //Muda para página contendo detalhes da ação
                    ),
                    Divider(
                      height: 2.0,
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue[600],
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.attach_money,
                  color: Colors.black,
                ),
                title: Text(
                  'Conversor',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.equalizer,
                  color: Colors.white,
                ),
                title: Text(
                  'Carteira',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ));
  }
}
