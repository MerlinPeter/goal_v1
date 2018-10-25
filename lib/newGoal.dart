import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/goal.dart';

class GoalForm extends StatefulWidget{
@override
State<StatefulWidget> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _goalName;
  String _goalDescription;
  DateTime _goalDate;
  /*String _goalDateTime;
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));

    if (picked != null && picked != _date) {
      print("Date selected ${_date.toString()}");
      setState(() {
        _date = picked;
      });
    }
  }*/
  void saveDB(BuildContext context){
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
        
       Firestore.instance.collection('goal').document().setData(
            Goal(null, 
                _goalName, 
                _goalDescription, 
                false, 
                new DateTime.now(),
                _goalDate).toMap(),
        );
       _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Saving Data')));
       Navigator.pop(context);         
    }
  }
   @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
 
     return new Scaffold(
       key: _scaffoldKey,
       appBar:new AppBar(
         title:new Text('New Goal'),
       ),
       body: 
        new Container(
         padding: EdgeInsets.all(16.0),
         child : new  Form(
          key: _formKey,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  <Widget>[
          TextFormField(
           decoration: new InputDecoration(labelText :'Goal Name'),
           validator: (value) {
              if (value.isEmpty) {
                return 'Please enter goal title';
              }
            },
            onSaved: (value) => _goalName = value ,
          ), 
          TextFormField(
           keyboardType: TextInputType.multiline,
           maxLines: 5,
           decoration: new InputDecoration(labelText :'Goal description'),
           validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Goal description';
              }
            },
            onSaved: (value) => _goalDescription = value ,
          ),
           TextFormField(
           decoration: new InputDecoration(labelText :'Goal Date'),
           initialValue: DateFormat.yMMMd("en_US").format(DateTime.now()).toString(),
            onSaved: (value) => _goalDate = DateFormat.yMMMd("en_US").parseStrict(value) ,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  saveDB(context);
                 }
              },
              child: Text('Submit'),
            ),
          ),
        ]
      )
    ),
    ),
    );

   }
}

