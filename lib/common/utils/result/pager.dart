import 'package:flutter_music_player/common/index.dart';
import 'package:flutter_music_player/common/utils/result/model.dart';

class Pager<T> extends Model<Pager<T>> {
  final int page;
  final int pageSize;
  final int totalSize;
  final int totalPage;
  final List<T>? items;

  const Pager({
    required this.page,
    required this.pageSize,
    required this.totalSize,
    required this.totalPage,
    required this.items,
  });

  bool get isEmpty => Helper.isEmpty(items);

  factory Pager.fromJson(Map<String, dynamic> json, Converter<T> converter) {
    final List<Map<String, dynamic>>? items = json["items"];
    return Pager(
      page: json['page'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      totalSize: json['totalSize'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
      items: items?.map((e) => converter(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'totalSize': totalSize,
      'totalPage': totalPage,
      'items': items?.map((e) => e.toString()).toList(),
    };
  }
}
