import 'dart:convert';

import 'package:forms_validations/src/preferences/user.preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final _baseUrl = 'https://identitytoolkit.googleapis.com/v1/';
  final _apiKey = 'AIzaSyCOQwmwmnqbQvxUQ6vcrUe_mvTHKnTuIAo';
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> add(String email, String password) async {
    final authRoute = 'accounts:signUp?key=';
    final data = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(_baseUrl + authRoute + _apiKey,
        body: json.encode(data));

    Map<String, dynamic> decoded = json.decode(response.body);

    print('auth data >>>>> $decoded');

    if (decoded.containsKey('idToken')) {
      return {'ok': true, 'token': decoded['idToken']};
    } else {
      return {'ok': true, 'token': decoded['error']['message']};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authRoute = 'accounts:signInWithPassword?key=';
    final data = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(_baseUrl + authRoute + _apiKey,
        body: json.encode(data));

    Map<String, dynamic> decoded = json.decode(response.body);

    print('auth data >>>>> $decoded');

    if (decoded.containsKey('idToken')) {
      _prefs.token = decoded['idToken'];
      return {'ok': true, 'token': decoded['idToken'], 'user': data};
    } else {
      return {'ok': false, 'token': decoded['error']['message']};
    }
  }
}
