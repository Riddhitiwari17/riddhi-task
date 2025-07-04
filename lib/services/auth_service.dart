import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (username == 'admin' && password == 'admin123') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      return true;
    }
    return false;
  }
}
