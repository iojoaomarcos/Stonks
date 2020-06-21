import 'package:flutter/material.dart';
import 'package:stonks/src/telaConfiguracoes.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class TelaMercado extends StatefulWidget {
  @override
  _TelaMercadoState createState() => _TelaMercadoState();
}

class _TelaMercadoState extends State<TelaMercado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mercado"),
        ),

        ////////////------------Navigation Bar----------------------***********
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: 1, // Use this to update the Bar giving a position
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
              } else {
                Navigator.pop(context);
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
