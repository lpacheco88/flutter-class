import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shopping_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final deviceData = await SharedPreferences.getInstance();
    if (!deviceData.containsKey('userData')) {
      return false;
    }

    final cachedData =
        json.decode(deviceData.getString('userData')) as Map<String, Object>;
    final expireDate = DateTime.parse(cachedData['expireDate']);

    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = cachedData['token'];
    _userId = cachedData['userId'];
    _expiryDate = expireDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    try {
      final url =
          Uri.parse('https://api.agendamentosantahelena.com.br/Account/SigIn');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {'login': "l_pacheco88@hotmail.com", "password": "123456"},
        ),
      );
      print(response);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
            seconds: int.parse(
          responseData['expiresIn'],
        )),
      );
      _autoLogout();
      notifyListeners();
      final deviceCache = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expireDate': _expiryDate.toIso8601String(),
        },
      );

      deviceCache.setString('userData', userData);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();
    final deviceData = await SharedPreferences.getInstance();
    deviceData.remove('userData');
    //kill all the stored data
    //deviceData.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
      Duration(seconds: timeToExpire),
      logout,
    );
  }
}
