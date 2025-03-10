import 'package:flutter_music_player/common/index.dart';
import 'package:flutter_music_player/common/utils/result/model.dart';

class Result extends Model<Result> {
  final int code;
  final String message;
  final dynamic data;

  const Result({required this.code, required this.message, required this.data});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }

  Result.of(this.code, {String? message})
    : data = null,
      message = message ?? "Unknown";

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'data': data.toString()};
  }

  // 判断业务请求是否成功
  bool get success => code == Constants.successCode;

  // 判断数据是否为空
  bool get isEmpty => Helper.isEmpty(data);

  // 判断data数据类型是否为列表
  bool get isArray => !isEmpty && data is Iterable;

  // 判断data的长度
  bool get size => isEmpty ? 0 : (isArray ? data.length : 1);

  // data转为model
  T toModel<T>(Converter<T> converter) => converter(data);

  // data转为List
  List<T> toArray<T>(Converter<T> converter) {
    if (isEmpty) return <T>[];
    if (isArray) {
      return data.map<T>((item) => converter(item)).toList();
    }
    return <T>[converter(data)];
  }
}
