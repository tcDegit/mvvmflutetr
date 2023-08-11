import 'package:dio/dio.dart';

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
