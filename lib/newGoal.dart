import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/goal.dart';
import 'goalType.dart';
import 'constants.dart';
import 'package:flutter/cupertino.dart';

class GoalForm extends StatefulWidget{
@override
State<StatefulWidget> createState() => _GoalFormState();
}
class _GoalFormState extends State<GoalForm> {
  
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _goalName;
  String _goalDescription;
  DateTime _goalDate = DateTime.now();
  DateTime _goalTimeDate = DateTime.now();
  TimeOfDay _goalTime = TimeOfDay.now();
  bool _isDaily = false;
  Duration timer = Duration();


  GOAL_REPEAT _goalType = GOAL_REPEAT.Never;

  _navigateAndSelectGoalType(BuildContext context) async {
        Object _goalTypei =  await  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoalType()),
        );
       _goalType = GOAL_REPEAT.values[int.parse(_goalTypei.toString())];
  
       if (_goalTypei == 1){
            _isDaily = true;
        }else{
            _isDaily = false;
       }
 //print('_goalTypei' + _goalTypei.toString());
  //    print('_isDaily' + _isDaily.toString());
    }

    Future<Null> selectDate(BuildContext context) async {
    final DateTime picker = await showDatePicker(
        context: context,
        initialDate: _goalDate,
        firstDate: new DateTime(2015,1),
        lastDate: new DateTime(2100,1)
    );
    if(picker != null && picker != _goalDate) {
      setState(() {
        _goalDate = picker;
       });
    }
  }
    Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picker = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
     );
    if(picker != null && picker != _goalTime) {
      setState(() {
        _goalTime = picker;
        _goalTimeDate = DateTime( DateTime.fromMicrosecondsSinceEpoch(0).year,  DateTime.fromMicrosecondsSinceEpoch(0).month,  DateTime.fromMicrosecondsSinceEpoch(0).day, _goalTime.hour, _goalTime.minute);

       });
    }
   
  }
  void saveDB(BuildContext context){
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      
  // print('dddd a' +   DateFormat('kk:mm').parseStrict(DateTime.now().toString()).toString());
 //  print('ddddd b'+ _goalDate.toString()); 
 
       Firestore.instance.collection('goal').document().setData(
            Goal(null, 
                _goalName, 
                _goalDescription, 
                false, 
                new DateTime.now(),
                _isDaily ?   new DateTime.fromMicrosecondsSinceEpoch(0):_goalDate ,
                _goalTimeDate,
                _goalType.index).toMap(),
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
        children:[
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
           maxLines: 2,
           decoration: new InputDecoration(labelText :'Goal description'),
           validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Goal description';
              }
            },
            onSaved: (value) => _goalDescription = value ,
          ),
          
          //repeat
          
          Row(
            children:[
              Expanded(
                child: /*_isDaily ? TextFormField(
           decoration: new InputDecoration(labelText :'Goal Time'),
           initialValue: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
            onSaved: (value) => _goalDate = DateFormat('kk:mm').parseStrict(value) ,
          )
          :
          TextFormField(
           decoration: new InputDecoration(labelText :'Goal Date'),
           initialValue:  _goalDate.toString() ,//DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
            onSaved: (value) => _goalDate = DateFormat('yyyy-MM-dd – kk:mm').parseStrict(value) ,
          ),*/
         _isDaily ?  Text('Daily'):
         Text('Goal Date : ' + DateFormat('MMM-dd-yyyy').format(_goalDate).toString())
              ),
          new IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  selectDate(context);
                }
            ),
            ],
          ),
          Row(
            children:[
              Expanded(
                child: 
          Text(_goalTime.format(context))
              ),
          new IconButton(
                icon: Icon(Icons.timer),
                onPressed: () {
                  selectTime(context);
                }
            ),
            ],
          ),
         Row(
            children:[
              Expanded(
              child :
               Text('Repeat Goal', style: TextStyle(color: Colors.black,)),
              ),
              Text( enumLabel(_goalType) ,  style: TextStyle(color: Colors.blue)),
              IconButton(
                  onPressed: (){_navigateAndSelectGoalType(context);},
                  icon: new Icon(Icons.arrow_forward_ios),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                 if (_formKey.currentState.validate()) {
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

