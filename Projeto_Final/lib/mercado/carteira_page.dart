import 'package:flutter/material.dart';
import 'package:projeto_final_acoes/conversor_moedas/conversor_page.dart';
import 'package:projeto_final_acoes/helpers/mercado_helper.dart';
import 'package:projeto_final_acoes/mercado/buscaAcao_page.dart';

class CarteiraPage extends StatefulWidget {
  @override
  _CarteiraPageState createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {

  CarteiraHelper helper = CarteiraHelper();

  List<Carteira> carteiras = List();

  Icon _cusIcon = Icon(Icons.search);
  Widget _cusSearchBar = Text("Carteira");

  @override
  void initState() {
    super.initState();

    helper.getAllCarteiras().then((list){
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
                      hintStyle: TextStyle(color: Colors.black)
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  );
                }
                else{
                  this._cusIcon = Icon(Icons.search);
                  this._cusSearchBar = Text("Carteira");
                }
              });
            }
          )
        ],
        elevation: 20.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => BuscaAcaoPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: carteiras.length,
        itemBuilder: (context, index) {
          return _carteiraCard(context, index);
        }
      ),
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

  Widget _carteiraCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(carteiras[index].sigla ?? "",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),  
              ),
            ],
          ),
        ),
      ),
    );
  }

}