import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class ThirdPageViewModel extends ChangeNotifier {
  List<UserModel> _users = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String _errorMessage = '';
  bool _hasError = false;
  int _currentPage = 1;
  bool _hasMoreData = true;
  String _selectedUser = '';

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String get errorMessage => _errorMessage;
  bool get hasError => _hasError;
  bool get hasUsers => _users.isNotEmpty;
  bool get hasMoreData => _hasMoreData;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setLoadingMore(bool loading) {
    _isLoadingMore = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _hasError = message.isNotEmpty;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
    _hasError = false;
    notifyListeners();
  }

  Future<void> fetchUsers({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMoreData = true;
      _users.clear();
    }

    _setLoading(true);
    _clearError();

    try {
      final newUsers = await ApiService.fetchUsers(page: _currentPage);

      if (refresh) {
        _users = newUsers;
      } else {
        _users.addAll(newUsers);
      }

      // Check if we have more data (ReqRes API returns 6 users per page by default)
      if (newUsers.length < 6) {
        _hasMoreData = false;
      }

      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _setError(e.toString());
    }
  }

  Future<void> loadMoreUsers() async {
    if (_isLoadingMore || !_hasMoreData) return;

    _setLoadingMore(true);
    _clearError();

    try {
      _currentPage++;
      final newUsers = await ApiService.fetchUsers(page: _currentPage);

      _users.addAll(newUsers);

      // Check if we have more data
      if (newUsers.length < 6) {
        _hasMoreData = false;
      }

      _setLoadingMore(false);
    } catch (e) {
      _currentPage--; // Reset page on error
      _setLoadingMore(false);
      _setError(e.toString());
    }
  }

  Future<void> refreshUsers() async {
    await fetchUsers(refresh: true);
  }

  UserModel? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  UserModel? getUserByIndex(int index) {
    if (index >= 0 && index < _users.length) {
      return _users[index];
    }
    return null;
  }

  void selectUser(UserModel user) {
    // This method can be used to handle user selection logic
    // For now, it just notifies listeners
    _selectedUser = user.name;
    notifyListeners();
  }

  void reset() {
    _users = [];
    _isLoading = false;
    _isLoadingMore = false;
    _errorMessage = '';
    _hasError = false;
    _currentPage = 1;
    _hasMoreData = true;
    notifyListeners();
  }
}
