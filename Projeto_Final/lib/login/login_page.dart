import 'package:flutter/material.dart';
import 'package:projeto_final_acoes/conversor_moedas/conversor_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          FlatButton(
            onPressed: (){},
            child: Text(
              "Criar Conta",
              style: TextStyle(fontSize: 15.0)
            ),
            textColor: Colors.black,
          )
        ],
      ),
      body: Form(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.blue, fontSize: 20.0),
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(color: Colors.red)
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.blue, fontSize: 20.0),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.red)
                  ),
                ),
              ),
              ButtonTheme(
                height: 60.0,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ConversorPage())
                    );
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)
                  ),
                  child: Text(
                    "Enviar",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                  color: Colors.red,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: (){},
                  child: Text("Esqueci minha senha",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.blue, fontSize: 15.0),
                  ),
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}