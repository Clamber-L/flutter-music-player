import 'package:dio/dio.dart';

/// 常量
class Constants {
  // 服务 api
  static const baseUrl =
      'https://mock.presstime.cn/mock/67ce5210ec85d3a70783775f';

  // 服务端返回状态码(成功)
  static const successCode = 200;

  // 请求头
  static const headers = {"version": "1.0.0", "flutter": "3.10.0"};

  //发送超时时间
  static const sendTimeout = Duration(seconds: 5);

  //连接超时时间
  static const connectTimeout = Duration(seconds: 5);

  //接收超时时间
  static const receiveTimeout = Duration(seconds: 5);

  //content-type
  static const contentType = Headers.formUrlEncodedContentType;

  //response-type
  static const responseType = ResponseType.json;

  //最小请求耗时
  static const minWaitingTime = 1000;
}
