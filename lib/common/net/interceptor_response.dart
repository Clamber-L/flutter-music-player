import 'package:dio/dio.dart';
import 'package:flutter_music_player/common/utils/result/result.dart';

final class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('response -> $response');
    // 将业务数据的data 放到response的data中
    if (response.statusCode == 200) {
      final result = Result.fromJson(response.data);

      // 请求正常 & 业务正常
      if (result.success) {
        response.data = result;
        response.statusCode = result.code;
        return handler.resolve(response);
      }

      // 请求正常 但是业务异常
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          // 错误对象和错误信息直接使用服务端返回的信息
          error: result,
          message: result.message,
        ),
      );
    }
    super.onResponse(response, handler);
  }
}
