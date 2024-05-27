import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _keyName = 'name';
  static const _keyEmail = 'email';
  static const _keyMobile = 'mobile';
  static const _keyPassword = 'password';

  // Setter for Name
  Future<void> setName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
  }

  // Getter for Name
  Future<String?> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  // Setter for Email
  Future<void> setEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  // Getter for Email
  Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // Setter for Mobile
  Future<void> setMobile(String mobile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyMobile, mobile);
  }

  // Getter for Mobile
  Future<String?> getMobile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyMobile);
  }

  // Setter for Password
  Future<void> setPassword(String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  // Getter for Password
  Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  // Method to clear all user info
  Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyMobile);
    await prefs.remove(_keyPassword);
  }
}
