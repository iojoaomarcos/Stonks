import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

void main() => runApp(MyApp());

//Para criar um StatelessWidget, basta stl + TAB
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Basics',
        // remove marca dagua DEBUG:
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //O tema permite definir paletas de cores:
          primarySwatch: Colors.red,
        ),
        home: BasicsHomePage());
  }
}

class BasicsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Para criar a tela, utilizasse o Scaffold em vez
    //de um container direto.
    //O scaffold eh basicamente a pagina em si
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
