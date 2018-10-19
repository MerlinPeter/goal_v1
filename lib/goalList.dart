import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('goal').orderBy('status').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  leading: new IconButton(icon:Icon( document['status'] ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    )
                    , onPressed: () {
                    var _status = document['status'] ? false : true ;
                     document.reference.updateData(
                         {'status':_status}
                      );
                    }  
                  ) ,
                  
                  title: new Text(document['title'],style:TextStyle(color:Colors.green ,fontWeight: FontWeight.bold)),
                  subtitle: new Text(document['status'].toString()),
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