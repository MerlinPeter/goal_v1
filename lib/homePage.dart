import 'package:flutter/material.dart';
import 'auth.dart';

class HomePage extends StatelessWidget{
 HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title : new Text('Welcome')
      ),
      body: new Container(
        child: new Center(
          child : new Text('Welcome', style: new TextStyle(fontSize:32.0))
        ),
      )
    );
  } 
}