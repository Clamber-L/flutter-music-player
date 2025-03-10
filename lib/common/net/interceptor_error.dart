import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_music_player/common/index.dart';

final class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('response error -> $err');

    // 如果上层拦截器处理过了 此处就不做处理
    if (err.error is Result) {
      return super.onError(err, handler);
    }

    final result = switch (err.type) {
      DioExceptionType.unknown => _unknown(err),
      DioExceptionType.connectionError => Result.of(
        0,
        message: 'connectionError',
      ),
      DioExceptionType.sendTimeout => Result.of(0, message: 'sendTimeout'),
      DioExceptionType.connectionTimeout => Result.of(
        0,
        message: 'connectionTimeout',
      ),
      DioExceptionType.receiveTimeout => Result.of(
        0,
        message: 'receiveTimeout',
      ),
      DioExceptionType.badCertificate => Result.of(
        0,
        message: 'badCertificate',
      ),
      DioExceptionType.badResponse => Result.of(0, message: 'badResponse'),
      DioExceptionType.cancel => Result.of(0, message: 'cancel'),
    };

    return handler.reject(err.copyWith(error: result, message: result.message));
  }

  Result _unknown(DioException err) {
    Object? error = err.error;
    if (error is HandshakeException) {
      return Result.of(0);
    }
    return Result.of(0);
  }
}
