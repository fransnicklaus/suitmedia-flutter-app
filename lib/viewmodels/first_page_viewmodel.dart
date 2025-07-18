import 'package:flutter/material.dart';

class FirstPageViewModel extends ChangeNotifier {
  String _userName = '';
  String _palindromeText = '';
  bool _isLoading = false;

  String get userName => _userName;
  String get palindromeText => _palindromeText;
  bool get isLoading => _isLoading;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setPalindromeText(String text) {
    _palindromeText = text;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool isPalindrome(String text) {
    if (text.isEmpty) return false;

    String cleanText = text
        .toLowerCase()
        .replaceAll(' ', '')
        .replaceAll(RegExp(r'[^a-z0-9]'), '');
    String reversedText = cleanText.split('').reversed.join('');
    return cleanText == reversedText;
  }

  String getPalindromeResult(String text) {
    if (text.isEmpty) return 'Please enter some text';

    bool result = isPalindrome(text);
    return result
        ? 'The text "$text" is a palindrome!'
        : 'The text "$text" is not a palindrome.';
  }

  String getPalindromeTitle(String text) {
    if (text.isEmpty) return 'Empty Text';

    bool result = isPalindrome(text);
    return result ? 'Is Palindrome' : 'Not Palindrome';
  }

  bool canProceedToNext() {
    return _userName.isNotEmpty;
  }

  void reset() {
    _userName = '';
    _palindromeText = '';
    _isLoading = false;
    notifyListeners();
  }
}
