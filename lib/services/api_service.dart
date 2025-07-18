import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static const String _baseUrl = 'https://reqres.in/api';

  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  static Future<List<UserModel>> fetchUsers(
      {int page = 1, int perPage = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users?page=$page&per_page=$perPage'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
        },
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final userData = jsonData['data'] as List;

        return userData.map((user) => UserModel.fromJson(user)).toList();
      } else if (response.statusCode == 401) {
        print('401 Unauthorized - Check your API key');
        throw Exception('Invalid API key. Please check your credentials.');
      } else if (response.statusCode == 403) {
        print('403 Forbidden - API access denied');
        throw Exception('Access denied. Please check your API permissions.');
      } else if (response.statusCode == 429) {
        print('429 Too Many Requests - Rate limited');
        throw Exception('Too many requests. Please try again later.');
      } else if (response.statusCode == 500) {
        print('500 Internal Server Error');
        throw Exception('Server error. Please try again later.');
      } else if (response.statusCode == 503) {
        print('503 Service Unavailable');
        throw Exception(
            'Service temporarily unavailable. Please try again later.');
      } else {
        throw Exception(
            'Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('ApiService error: $e');
      if (e.toString().contains('Invalid API key') ||
          e.toString().contains('Access denied') ||
          e.toString().contains('Too many requests') ||
          e.toString().contains('Server error') ||
          e.toString().contains('Service temporarily unavailable')) {
        rethrow; // Re-throw specific API errors
      } else if (e.toString().contains('SocketException')) {
        throw Exception('No internet connection. Please check your network.');
      } else if (e.toString().contains('TimeoutException')) {
        throw Exception('Request timeout. Please try again.');
      } else if (e.toString().contains('FormatException')) {
        throw Exception('Invalid response format from server.');
      } else {
        throw Exception('Network error: ${e.toString()}');
      }
    }
  }

  static Future<UserModel> fetchUser(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
        },
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final userData = jsonData['data'];

        return UserModel.fromJson(userData);
      } else if (response.statusCode == 401) {
        print('401 Unauthorized - Check your API key');
        throw Exception('Invalid API key. Please check your credentials.');
      } else if (response.statusCode == 403) {
        print('403 Forbidden - API access denied');
        throw Exception('Access denied. Please check your API permissions.');
      } else if (response.statusCode == 404) {
        print('404 Not Found - User not found');
        throw Exception('User not found.');
      } else if (response.statusCode == 429) {
        print('429 Too Many Requests - Rate limited');
        throw Exception('Too many requests. Please try again later.');
      } else if (response.statusCode == 500) {
        print('500 Internal Server Error');
        throw Exception('Server error. Please try again later.');
      } else if (response.statusCode == 503) {
        print('503 Service Unavailable');
        throw Exception(
            'Service temporarily unavailable. Please try again later.');
      } else {
        throw Exception(
            'Failed to load user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('ApiService error: $e');
      if (e.toString().contains('Invalid API key') ||
          e.toString().contains('Access denied') ||
          e.toString().contains('User not found') ||
          e.toString().contains('Too many requests') ||
          e.toString().contains('Server error') ||
          e.toString().contains('Service temporarily unavailable')) {
        rethrow; // Re-throw specific API errors
      } else if (e.toString().contains('SocketException')) {
        throw Exception('No internet connection. Please check your network.');
      } else if (e.toString().contains('TimeoutException')) {
        throw Exception('Request timeout. Please try again.');
      } else if (e.toString().contains('FormatException')) {
        throw Exception('Invalid response format from server.');
      } else {
        throw Exception('Network error: ${e.toString()}');
      }
    }
  }
}
