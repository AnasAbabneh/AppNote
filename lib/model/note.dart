class Note {

  int _id;
  String _title;
  String _body;
  String _time;

  Note( this._title, this._body, this._time);

  Note.map(dynamic obj){
    this._id = obj['id'];
    this._body = obj['title'];
    this._title = obj['body'];
    this._time = obj['time'];
  }

  int get id => _id;
  String get title => _title;
  String get body => _body;
  String get time => _time;

  //add and update { from app to db }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['body'] = _body;
    map['time'] = _time;

    return map;
  }

  //show'get' {from db to app }
  Note.fromMap(Map<String , dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._body = map['body'];
    this._time = map['time'];
  }
}
