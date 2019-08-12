import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier{
  bool _isRegister = false;

  bool get isRegister => _isRegister;
  Color get color => _isRegister ? Colors.red : Colors.blue;

  void toggle(){
    _isRegister = !_isRegister;
    notifyListeners();
  }
}