import 'package:dio/dio.dart';
import 'package:flutter_music_player/common/net/http.dart';
import 'package:flutter_music_player/common/utils/result/model.dart';
import 'package:flutter_music_player/common/utils/result/pager.dart';
import 'package:flutter_music_player/common/utils/result/result.dart';

class HttpApi<M extends Model<M>> {
  final Converter<M> converter;
  const HttpApi(this.converter);

  Future<M> get(
    String path, {
    Duration? delay,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return Http.get<Result>(
      path,
      query: query,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    ).then((res) => res.toModel(converter)); // 统一转换成 Model 类
  }

  Future<List<M>> getList(
    String path, {
    Duration? delay,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return Http.get<Result>(
      path,
      query: query,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    ).then((res) => res.toArray(converter)); // 转换成 Model 列表
  }

  Future<Pager<M>> getPageList(
    String path, {
    Duration? delay,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return Http.get<Result>(
      path,
      query: query,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    ).then((res) => res.toModel((data) => Pager<M>.fromJson(data, converter)));
  }

  Future<bool> post(
    String path, {
    Object? data,
    Duration? delay,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return Http.post<Result>(
      path,
      data: _dataExpand(data),
      query: query,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ).then((res) => res.success);
  }

  static Object? _dataExpand(Object? data) {
    return data == null ? null : (data is Model ? data.toJson() : data);
  }
}
