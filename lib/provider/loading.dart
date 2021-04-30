import 'package:flutter/material.dart';

class LoadingControl with ChangeNotifier {
  // ignore: non_constant_identifier_names
  void add_loading() {
    notifyListeners();
  }
}
