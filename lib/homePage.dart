import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'goalList.dart';

class HomePage extends StatelessWidget{
 HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async{
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
    }
  }

  void saveDB() async{
    Firestore.instance.collection('goal').document().setData(
      {'title': 'bible reading','status':false}
    );
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title : new Text('Welcome'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0 ,  color: Colors.white)),
            onPressed: _signOut,
          )
           
        ],
      ),
      body: new GoalList(),
      floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed: saveDB,
          )
    );
  } 
}

/*new Container(
        child: new Center(
          child : //new Text('Welcome', style: new TextStyle(fontSize:32.0)) ,
          
            new FlatButton(
            child: new Text('Save', style: new TextStyle(fontSize: 17.0 ,  color: Colors.green)),
            onPressed: saveDB,
          )
        ),
      )*/