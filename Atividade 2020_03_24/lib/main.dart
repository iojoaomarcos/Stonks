import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Software',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  final String title = 'Meu Software';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Lista de Nomes',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Text('Alunos da USF',
                    style: TextStyle(
                      fontSize: 15.0
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/abacaxi.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Abacaxi',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/caipirinha.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Caipirinha',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/coca.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Coca Cola',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/hamburguer.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Hamburguer',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/hotdog.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Hot Dog',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/pacoca.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Paçoca',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/pastel.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Pastel',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/pipoca.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Pipoca',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/pizza.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Pizza',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "images/sorvete.jpg",
                      fit: BoxFit.contain,
                      height: 100.0,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Sorvete',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.equalizer),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySecondPage()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MySecondPage extends StatefulWidget {
  MySecondPage({Key key}) : super(key: key);

  final String title = 'Notas dos Alunos';

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: Text('Lista de Nomes',
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Center(
                    child: Text('Alunos da USF',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text('José Arnaldo dos Santos'),
                      margin: EdgeInsets.all(25.0),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text('7,8',
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text('Felipe Teixeira Lopez'),
                      margin: EdgeInsets.all(25.0),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text('7,0',
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('Ricardo Buldenbergue'),
                    margin: EdgeInsets.all(25.0),
                  ),
                  Container(
                    child: Text('6,9',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text('João Marcelo Monte'),
                      margin: EdgeInsets.all(25.0),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text('8,0',
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text('Rubens Marilendo Alquindo'),
                      margin: EdgeInsets.all(25.0),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text('10,0',
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('Matheus Matias Peireira'),
                    margin: EdgeInsets.all(25.0),
                  ),
                  Container(
                    child: Text('7,0',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('Lucas Carvalho'),
                    margin: EdgeInsets.all(25.0),
                  ),
                  Container(
                    child: Text('8,0',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('Monica Roberta'),
                    margin: EdgeInsets.all(25.0),
                  ),
                  Container(
                    child: Text('7,0',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('Alessandra Fonseca'),
                    margin: EdgeInsets.all(25.0),
                  ),
                  Container(
                    child: Text('7,0',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('Cristina Pedroso'),
                    margin: EdgeInsets.all(25.0),
                  ),
                  Container(
                    child: Text('7,0',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 20.0),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.equalizer),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySecondPage()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
