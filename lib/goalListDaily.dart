import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/goal.dart';
import 'package:intl/intl.dart';

class GoalListDaily extends StatefulWidget {
GoalListDaily({this.showCompleted});

  final  bool showCompleted;

 @override
State<StatefulWidget> createState()  => _GoalListDailyState();

}

class _GoalListDailyState extends State<GoalListDaily>{

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
                                                  .where('goal_type',isEqualTo: 1)
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
              shrinkWrap:true,
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                 var goal =  Goal.fromMap(document.data);
                 return new ListTile(
                 leading: new IconButton(icon:Icon( goal.status? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    )
                    , onPressed: () {
                       
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
                                   new Text(goal.status ? "Completed":"New" ),
                                   new Text( 'Time : ' +DateFormat.jm().format(goal.goaltime).toString() )
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