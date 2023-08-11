import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter/API/login_api.dart';
import 'package:mvvm_flutter/model/login_model.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginAPI _loginAPI = LoginAPI();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  dynamic _result = "";

  User? _loginModel;

  TextEditingController get usernameController {
    return _usernameController;
  }

  TextEditingController get passwordController {
    return _passwordController;
  }

  dynamic get result {
    return _result;
  }

  User? get loginModel {
    return _loginModel;
  }

  setResult(dynamic data) {
    _result = data;
    notifyListeners();
  }

  login() async {
    final result = await _loginAPI.login({
      "username": _usernameController.text,
      "password": _passwordController.text,
    });
    _loginModel = User.fromJson(result);
    setResult(result.toString());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
