class Note {
  int _id;
  String _name;
  String _age;

  Note(this._name, this._age);

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._age = obj['age'];
  }

  int get id => _id;
  String get name => _name;
   String get age => _age;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['age'] = _age;
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._age = map['age'];
  }
}