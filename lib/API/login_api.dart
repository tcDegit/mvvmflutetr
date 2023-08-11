import 'package:mvvm_flutter/utils/HttpClient.dart';

class LoginAPI {
  dynamic login(Map<String, String> map) async {
    final result = await HttpClient.instance.post('/user/login', map);
    return result?.data ?? "";
  }
}
