import 'package:flutter/cupertino.dart';
import 'package:footapp/models/player.dart';

class SelectPlayerProvider with ChangeNotifier {
  List<Player> _list = [];

  void add(Player p) {
    _list.add(p);
    notifyListeners();
  }

  void delete(Player p) {
    _list.remove(p);
    notifyListeners();
  }

  void deleteAt(int p) {
    _list.removeAt(p);
    notifyListeners();
  }

  void cleanL() {
    _list.clear();
  }

  int get count {
    return _list.length;
  }

  List<Player> get players {
    return _list;
  }

  Player show(int i) {
    return _list[i];
  }
}
