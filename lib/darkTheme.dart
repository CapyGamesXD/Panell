import 'package:flutter/material.dart';

class darkTheme extends ChangeNotifier {
  bool darkMode = false;

  void toggle() {
    darkMode = !darkMode;
    notifyListeners();
  }
}
