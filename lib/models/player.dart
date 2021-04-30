class Player {
  int _id;
  String _name;
  String _poste;
  String _team;

  Player(dynamic obj) {
    _id = obj["id"];
    _name = obj["name"];
    _poste = obj["poste"];
    _team = obj["team"];
  }
  Player.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _name = map["name"];
    _poste = map["poste"];
    _team = map["team"];
  }
  Map<String, dynamic> toMap() =>
      {'id': _id, 'name': _name, 'poste': _poste, 'team': _team};
  int get id => _id;
  String get poste => _poste;
  String get team => _team;
  String get name => _name;
}
