import 'package:flutter/material.dart';
import 'auth.dart';
import 'goalList.dart';
import 'newGoal.dart';

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

  

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title : new Text('Daily Goals'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0 ,  color: Colors.white)),
            onPressed: _signOut,
          )
           
        ],
      ),
      body: new GoalList(),
      floatingActionButton:Column(
         
          mainAxisAlignment:  MainAxisAlignment.end,
          crossAxisAlignment : CrossAxisAlignment.end,
          children:<Widget>[ 
            new FloatingActionButton(
            heroTag: 'xxx',
            child: new Icon(Icons.add),
            onPressed: (){ Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GoalForm()),
            );
            },
          ),
          new FloatingActionButton(
            child: new Icon(Icons.view_compact),
            heroTag: 'yyy',
            onPressed: (){ 
              print("dont crash");
            },
          ),
           ] 
         )    
    );
  } 
}

