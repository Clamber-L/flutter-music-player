import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_music_player/common/index.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final class Http {
  late final Dio _dio;

  static Http? _instance;

  factory Http() => _instance ??= Http._();

  Http._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: Constants.headers,
        sendTimeout: Constants.sendTimeout,
        connectTimeout: Constants.connectTimeout,
        receiveTimeout: Constants.receiveTimeout,
        contentType: Constants.contentType,
        responseType: Constants.responseType,
      ),
    );

    // log
    _dio.interceptors.add(
      PrettyDioLogger(
        enabled: true,
        responseBody: false,
        request: false,
        requestBody: false,
      ),
    );
    _dio.interceptors.add(CacheInterceptor());
    _dio.interceptors.add(ResponseInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
  }

  static Dio get dio => Http()._dio;

  static void changeBaseUrl(String url) => dio.options.baseUrl = url;

  static void resetBaseUrl() => changeBaseUrl(Constants.baseUrl);

  static Future<T> get<T>(
    String path, {
    Duration? delay,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _fetch(
      dio.get(
        path,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
      delay,
    );
  }

  static Future<T> post<T>(
    String path, {
    Duration? delay,
    Object? data,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _fetch(
      dio.post(
        path,
        data: data,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      delay,
    );
  }

  static Future<T> _fetch<T>(Future<Response> future, Duration? delay) {
    final start = Helper.timestamp();

    return future
        .then<T>((resp) {
          //计算请求结束时间和请求开始时间的差值 就是请求耗时
          final timeConsume = Helper.timestamp() - start;
          // 最小请求耗时
          final waitingTime = Constants.minWaitingTime;
          // 如果没有设置时间 或者请求耗时大于最小请求耗时 则直接返回结果
          if (delay == null || timeConsume > waitingTime) {
            return resp.data!;
          }
          return Future.delayed(
            Duration(milliseconds: waitingTime - timeConsume),
            () => resp.data!,
          );
        })
        .catchError((err) {
          if (err is DioException && err.error is Result) {
            final result = err.error as Result;
            debugPrint('统一异常处理: $result');
            throw result;
          }
          throw Result.of(0, message: err.toString());
        });
  }
}
