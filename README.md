# mvvmflutetr

[TOC]

# Flutter MVVM架构

## 概述

MVVM即 Model-View-ViewModel的缩写。

-   View层：显示界面。
-   Model层：数据请求、存储。
-   ViewModel：业务逻辑处理，连接View和Model层。



## 具体实现

### 添加依赖库

```
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.3
  dio: ^4.0.6
```



### 简单封装网络请求框架

新建dio_utils.dart文件：

```dart
class HttpClient {
  late Dio dio;
  static HttpClient instance = HttpClient._internal();

  ///工厂构造函数与普通构造函数的区别在于，
  ///工厂构造函数可以自定义实例的创建过程，并根据需要返回一个新的对象或现有的对象。
  factory HttpClient() {
    return instance;
  }

  HttpClient._internal() {
    dio = Dio();
    dio.options.baseUrl = "https://www.wanandroid.com";
    dio.options.connectTimeout = 8000;
    dio.interceptors.add(LogInterceptor(responseBody: true)); // 输出响应内容体
  }

  /// get请求
  Future<Response?> get(String url, {Map<String, dynamic>? map}) async {
    try {
      var result = await dio.get(url, queryParameters: map);
      return result;
    } catch (e) {
      return null;
    }
  }

  ///post请求
  Future<Response?> post(String url, Map<String, dynamic>? map) async {
    try {
      var result = await dio.post(url, queryParameters: map);
      return result;
    } catch (e) {
      return null;
    }
  }
}
```



### 创建Model层

新建login_model.dart文件：

```dart

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User {
  @JsonKey(name: 'errorMsg')
  String errorMsg;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'data')
  UserData? data;

  User(this.errorCode, this.errorMsg);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: 'admin')
  bool? admin;

  @JsonKey(name: 'coinCount')
  int? coinCount;

  @JsonKey(name: 'collectIds')
  List<int>? collectIds;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'icon')
  String? icon;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'password')
  String? password;

  @JsonKey(name: 'publicName')
  String? publicName;

  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'type')
  int? type;

  @JsonKey(name: 'username')
  String? username;

  UserData(
      this.admin,
      this.coinCount,
      this.collectIds,
      this.email,
      this.icon,
      this.id,
      this.nickname,
      this.password,
      this.publicName,
      this.token,
      this.type,
      this.username);
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

```


### 创建API层
```dart
import 'package:mvvm_flutter/utils/dio_utils.dart';
class LoginAPI {
  dynamic login(Map<String, String> map) async {
    final result = await HttpClient.instance.post('/user/login', map);
    return result?.data ?? "";
  }
}
```


### 创建ViewModel层

```dart
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

```



### 创建View层

```dart
import 'package:flutter/material.dart';
import 'package:mvvm_flutter/viewmodel/LoginViewModel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel loginViewModel;

  @override
  void dispose() {
    loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MVVM学习"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("登陆功能"),
            TextField(
              controller: loginViewModel.usernameController,
              decoration: const InputDecoration(
                labelText: "用户名",
                prefixIcon: Icon(Icons.supervised_user_circle),
              ),
            ),
            TextField(
              controller: loginViewModel.passwordController,
              decoration: const InputDecoration(
                labelText: "密码",
                prefixIcon: Icon(Icons.verified_user),
              ),
              obscureText: true,
            ),
            OutlinedButton(
              onPressed: () {
                loginViewModel.setResult("");
                loginViewModel.login();
              },
              child: const Text("登陆"),
            ),
            Text(loginViewModel.result),
            loginViewModel.loginModel == null
                ? SizedBox()
                : Column(
                    children: [
                      Text("loginViewModel中json转model"),
                      Text(loginViewModel.loginModel!.errorMsg),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

```



### 配色Provider状态管理

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM学习',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
    );
  }
}
```





