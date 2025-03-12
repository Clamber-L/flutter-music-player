import 'dart:convert';

typedef Converter<T> = T Function(Map<String, dynamic>);

abstract class Model<T extends Model<T>> {
  const Model();

  Map<String, dynamic> toJson();

  String get id => "0";

  @override
  String toString() => json.encode(this);
}
