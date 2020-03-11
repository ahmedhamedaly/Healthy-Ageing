import 'package:flutter/material.dart';
import'./homepage.dart';


class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('Log In'),
            ),
            body: Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new MyHomePage(title: '');
                      }));
                },
                child: Text('Homepage'),
              ),
            ),
          ),
    );
  }
}