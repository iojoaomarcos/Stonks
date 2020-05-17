import 'package:flutter/material.dart';
import 'package:projeto_final_acoes/conversor_moedas/conversor_page.dart';
import 'package:projeto_final_acoes/helpers/mercado_helper.dart';
import 'package:projeto_final_acoes/mercado/buscaAcao_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projeto_final_acoes/mercado/stock.dart';

class CarteiraPage extends StatefulWidget {
  CarteiraPage({Key key}) : super(key: key); ////////Chave para lista Mercado
  @override
  _CarteiraPageState createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  List<Stock> stockList = [];

  //itens estaticos
  final items = List<String>.generate(
      20, (i) => "Item qwerty ${i + 1}"); //////lista Mercado

  CarteiraHelper helper = CarteiraHelper();

  List<Carteira> carteiras = List();

  Icon _cusIcon = Icon(Icons.search);
  Widget _cusSearchBar = Text("Mercado");

  @override
  void initState() {
    super.initState();
/////////////////////////////////////////////
    DatabaseReference stocksRef =
        FirebaseDatabase.instance.reference().child("u1");

    stocksRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      stockList.clear();

      for (var individualKey in KEYS) {
        Stock stonks = new Stock(
          DATA[individualKey]['business'],
          DATA[individualKey]['stock'],
        );

        stockList.add(stonks);
      }

      setState(() {
        print('Tamanho da lista de acoes: $stockList.lenght');
      });
    });
    /////////////////////////////////////////////////

    helper.getAllCarteiras().then((list) {
      setState(() {
        carteiras = list;
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

      // Codigo do Felipe (comentado pelo Joao Marcos)
      // body: ListView.builder(
      //     padding: EdgeInsets.all(10.0),
      //     itemCount: carteiras.length,
      //     itemBuilder: (context, index) {
      //       return _carteiraCard(context, index);
      //     }),

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          // itemCount: stockList.length,
          // itemBuilder: (_, index) {
          //   final item = items[index];

          return Dismissible(
            key: Key(item), // Chave de identificacao de item
            onDismissed: (direction) {
              // Se arrastado, remove da lista
              setState(() {
                items.removeAt(index);
              });

              //Confirmando que item foi removido
              Scaffold.of(context) //item =
                  .showSnackBar(
                      SnackBar(content: Text("$item Foi removido da lista")));
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
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ConversorPage()),
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
    );
  }

  Widget _carteiraCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                carteiras[index].sigla ?? "",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
