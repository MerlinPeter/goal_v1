import 'package:flutter/material.dart';
import 'rootPage.dart';
import 'auth.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){

     return new MaterialApp(
       title: 'Goal App Login' ,
       theme: new ThemeData( primarySwatch: Colors.blue,
     ),
     home :new RootPage(auth: new Auth())
     );
  }
}