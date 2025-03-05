import 'package:flutter/material.dart';
import 'package:integradora/controller/clase_usuario.dart'; // Importa tu modelo de usuario

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
