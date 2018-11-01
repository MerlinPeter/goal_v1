import 'package:flutter/material.dart';

class Goal {
  String _id;
  String _title;
  String _description;
  bool _status;
  DateTime _created;
  DateTime _goaldate;
  DateTime _goaltime;
  int _goaltype;
 
  Goal(this._id, 
  this._title,
  this._description,
  this._status, 
  this._created,
  this._goaldate ,
  this._goaltime ,
  this._goaltype);
 
  Goal.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
    this._status = obj['status'];
    this._created = obj['created_dt'];
    this._goaldate = obj['goal_date'];
    this._goaldate = obj['goal_time'];
    this._goaltype = obj['goal_type'];
  }
 
  String get id => _id;
  String get title => _title;
  String get description => _description;
  bool get status => _status;
  DateTime get created => _created;
  DateTime get goaldate => _goaldate;
  DateTime get goaltime => _goaltime;
  int get goaltype => _goaltype;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['status'] = _status;
    map['created_dt'] = _created;
    map['goal_date'] = _goaldate;
    map['goal_time'] = _goaltime;
    map['goal_type'] = _goaltype;
    return map;
  }
 
  Goal.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._status = map['status'];
    this._created = map['created_dt'];
    this._goaldate = map['goal_date'] ?? new DateTime.fromMicrosecondsSinceEpoch(0);
    this._goaltype = map['goal_type'];
    this._goaltime = map['goal_time'];
  }
}