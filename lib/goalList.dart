import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/goal.dart';
import 'package:intl/intl.dart';

class GoalList extends StatefulWidget {
GoalList({this.showCompleted});

  final  bool showCompleted;

 @override
State<StatefulWidget> createState()  => _GoalListState();

}

class _GoalListState extends State<GoalList>{

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final lastMidnight = new DateTime(now.year, now.month, now.day);
    final tomorrowNoon = new DateTime(now.year, now.month, now.day + 1);
    Stream<QuerySnapshot> query;
  
    query =  Firestore.instance.collection('goal') 
                                                  .where('status', isEqualTo: false)
                                                  .where('goal_date',isGreaterThanOrEqualTo: lastMidnight)
                                                  .where('goal_date',isLessThan: tomorrowNoon)
                                                  .orderBy('goal_date', descending: false)
                                                  .snapshots();
    if (widget.showCompleted){
         query =  Firestore.instance.collection('goal') 
                                                  .where('goal_date',isGreaterThanOrEqualTo: lastMidnight)
                                                  .where('goal_date',isLessThan: tomorrowNoon)
                                                  .orderBy('goal_date', descending: false)
                                                  .snapshots();
    }
  
    return StreamBuilder<QuerySnapshot>(
       stream: query,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                 var goal =  Goal.fromMap(document.data);
                print(goal.toMap());
                 print('show completed goal list :  ' + widget.showCompleted.toString());
                 return new ListTile(
                 leading: new IconButton(icon:Icon( goal.status? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    )
                    , onPressed: () {
                      print(document['goal_date']);
                      print(DateFormat.yMMMd("en_US").format(DateTime.now()));
                      
                    var _status = goal.status ? false : true ;
                     document.reference.updateData(
                         {'status':_status}
                      );
                    }  
                  ) ,

                  title: new Text(goal.title   ,style:TextStyle(color:Colors.green ,fontWeight: FontWeight.bold)),
                  subtitle: Row(
                                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                  children:<Widget>[
                                  new Text(DateFormat.yMMMd("en_US").format(goal.goaldate).toString() ,textAlign: TextAlign.start),
                                  new Text(goal.description )
                                   ]
                                  ),
                  trailing: new IconButton(icon:Icon(Icons.delete), onPressed: () {
                    document.reference.delete();
                  }  ) ,
                );
              }).toList(),
            );
        }
      },
    );
  }
}