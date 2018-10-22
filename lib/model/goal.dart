class Goal {
  String _id;
  String _title;
  String _description;
  bool _status;
  DateTime _created;
  DateTime _goaldate;
 
  Goal(this._id, this._title, this._description, this._status, this._created, this._goaldate);
 
  Goal.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
    this._status = obj['status'];
    this._created = obj['created_dt'];
    this._created = obj['goal_date'];
  }
 
  String get id => _id;
  String get title => _title;
  String get description => _description;
  bool get status => _status;
  DateTime get created => _created;
  DateTime get goaldate => _goaldate;
 
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
 
    return map;
  }
 
  Goal.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._status = map['status'];
    this._created = map['created_dt'];
    this._goaldate = map['goal_date'];
  }
}