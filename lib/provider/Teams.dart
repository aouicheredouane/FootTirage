import 'package:flutter/cupertino.dart';
import 'package:footapp/models/player.dart';

class SelectTeamProvider with ChangeNotifier {
  String _remplacent;
  List<Player> _teamA = [];
  List<Player> _teamB = [];
  void addTeamA(Player p) {
    _teamA.add(p);
    notifyListeners();
  }

  void addTeamB(Player p) {
    _teamB.add(p);
    notifyListeners();
  }

  void addRemp(String r) {
    _remplacent = r;
    notifyListeners();
  }

  void cleanA() {
    _teamA.clear();
  }

  int get countA {
    return _teamA.length;
  }

  void cleanB() {
    _teamB.clear();
  }

  int get countB {
    return _teamB.length;
  }

  String get remp => _remplacent;
  List<Player> get teamA => _teamA;
  List<Player> get teamB => _teamB;
}
