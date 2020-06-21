import 'package:flutter/material.dart';
import 'package:stonks/src/telaConfiguracoes.dart';
import 'package:stonks/src/telaConversorMoedas.dart';
import 'package:stonks/src/telaMercado.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stonks',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variaveis
  int _currentIndex = 0;
  final List<Widget> _children = [
    //telaConversorMoedas();
    //telaMercado();
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Conversor de Moedas"),
        ),
        //body: _children,

        ////////////------------Navigation Bar----------------------***********
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: 0, // Use this to update the Bar giving a position
            onTap: (index) {
              print("Selected Index: $index");
              //TO DO: if 1...
              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaMercado()),
                );
              }
            },
            items: [
              TitledNavigationBarItem(
                  title: 'Conversor', icon: Icons.attach_money),
              TitledNavigationBarItem(
                  title: 'Mercado', icon: Icons.trending_up),
              TitledNavigationBarItem(title: 'Ajustes', icon: Icons.settings),
            ]));
  }
}
