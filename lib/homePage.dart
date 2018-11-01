import 'package:flutter/material.dart';
import 'auth.dart';
import 'goalList.dart';
import 'goalListDaily.dart';
import 'newGoal.dart';

class HomePage extends StatefulWidget{
HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

 @override
  State<StatefulWidget> createState() => new _HomePageState();

}
 
class _HomePageState extends State<HomePage> {
  bool _showCompleted = true;

  void _signOut() async{
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
    }
  }
  void _toggleCompleted() {
    setState(() {
       if (_showCompleted) {
         _showCompleted = false;
       } else {
         _showCompleted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context){
     return new Scaffold(
      appBar: new AppBar(
        title : new Text(' Goals'),
        actions: <Widget>[
             new FlatButton(
            child: new Icon(Icons.check_box ,color: Colors.white,) ,
            onPressed: _signOut,
          ),
          new FlatButton(
            child: new Icon(Icons.arrow_back_ios ,color: Colors.white,) ,
            onPressed: _signOut,
          ),
          new FlatButton(
                        child: new Icon(Icons.arrow_forward_ios,color: Colors.white),
            //child: new Text('Logout', style: new TextStyle(fontSize: 17.0 ,  color: Colors.white)),
            onPressed: _signOut,
          )
        ],
      ),
      body: //Column(children: <Widget>[
          /*  RaisedButton(onPressed: _toggleCompleted ,
            child: new Text(
                      _showCompleted ? "Hide Completed" : "Show Completed",
                    )
                ),*/
                Column(
 
                children: <Widget>[
                    Text(
                    'Todays Goals',
                    textAlign: TextAlign.center,
                     style: TextStyle(color:Colors.redAccent ,fontWeight: FontWeight.bold),
                    ),
                    new GoalList(showCompleted:_showCompleted ),
                    Text(
                    'Repeating Daily Goals',
                    textAlign: TextAlign.center,
                     style: TextStyle(color:Colors.redAccent ,fontWeight: FontWeight.bold),
                    ),
                    new GoalListDaily(showCompleted:_showCompleted )
                ],
                ),
      // ]
     // ),
      floatingActionButton:
            new FloatingActionButton(
            heroTag: 'xxx',
            child: new Icon(Icons.add),
            onPressed: (){ Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GoalForm()),
            );
            },
          ) 
    );
  } 
}

