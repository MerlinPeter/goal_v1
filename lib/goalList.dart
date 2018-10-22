import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/goal.dart';
import 'package:intl/intl.dart';

class GoalList extends StatelessWidget {
 //GoalList({ this.showCompleted});
  //final bool showCompleted;


  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final lastMidnight = new DateTime(now.year, now.month, now.day);
    return StreamBuilder<QuerySnapshot>(
      //where('goal_date',isGreaterThanOrEqualTo: lastMidnight)
      stream: Firestore.instance.collection('goal')//.orderBy('created_dt',descending: false)
                                                   //.where('status',isEqualTo: false)
                                                    .where('goal_date',isGreaterThanOrEqualTo: lastMidnight)
                                                  // .where('status',isEqualTo: false)
                                                    // .where('title',isEqualTo: 'test')
                                                    .orderBy('goal_date',descending: true)
                                                    //.orderBy('status',descending: true)
                                                   .snapshots(),
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
                print(document.exists);
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