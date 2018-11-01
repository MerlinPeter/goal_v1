import 'package:flutter/material.dart';
import 'package:goal_v1/constants.dart';

class GoalType extends StatelessWidget{

@override
  Widget build(BuildContext context) {
    final title = 'Repeat';
    return Scaffold(
        appBar: AppBar(
          title: Text(title)
        ),
        body: ListView(
          
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(enumLabel(GOAL_REPEAT.Daily)),
              onTap: (){Navigator.pop(context,GOAL_REPEAT.Daily.index);},
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(enumLabel(GOAL_REPEAT.Weekly)),
               onTap: (){Navigator.pop(context,GOAL_REPEAT.Weekly.index);},
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(enumLabel(GOAL_REPEAT.Never)),
             onTap: (){Navigator.pop(context,GOAL_REPEAT.Never.index);},
            ),
          ],
        ),
    );
  }
}