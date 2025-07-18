import 'package:flutter/material.dart';

class SecondPageViewModel extends ChangeNotifier {
  String _userName = '';
  String _selectedUserName = '';
  bool _isLoading = false;

  String get userName => _userName;
  String get selectedUserName => _selectedUserName;
  bool get isLoading => _isLoading;

  String get displaySelectedUser =>
      _selectedUserName.isEmpty ? 'Selected User Name' : _selectedUserName;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setSelectedUserName(String name) {
    _selectedUserName = name;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool hasSelectedUser() {
    return _selectedUserName.isNotEmpty;
  }

  void clearSelectedUser() {
    _selectedUserName = '';
    notifyListeners();
  }

  void reset() {
    _userName = '';
    _selectedUserName = '';
    _isLoading = false;
    notifyListeners();
  }
}
