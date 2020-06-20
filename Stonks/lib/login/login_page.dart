import 'package:flutter/material.dart';
import 'package:projeto_final_acoes/conversor_moedas/conversor_page.dart';
import 'package:projeto_final_acoes/helpers/firebase_auth.dart';
import 'package:projeto_final_acoes/helpers/appSize.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Responsive APP
  double setWidth(double value) {
    return value * AppSize.widthProportions(MediaQuery.of(context).size.width);
  }

  double setHeight(double value) {
    return value *
        AppSize.heightProportions(MediaQuery.of(context).size.height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlue[200], Colors.lightBlue[800]],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: setWidth(250.0), bottom: setWidth(70.0)),
                child: Image(
                    image: AssetImage("images/stonks.png"),
                    height: setWidth(80.0)),
              ),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(setWidth(40.0))),
      ),
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          authService.signInWithGoogle().whenComplete(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return ConversorPage();
                },
              ),
            );
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, setHeight(10.0), 0, setHeight(10.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("images/google_logo.png"),
                  height: setHeight(20.0)),
              Padding(
                padding: EdgeInsets.only(left: setWidth(10.0)),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: setWidth(20.0),
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
