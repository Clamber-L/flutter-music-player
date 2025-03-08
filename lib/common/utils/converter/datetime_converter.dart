import 'package:json_annotation/json_annotation.dart';

class DatetimeConverterTimestamp extends JsonConverter<DateTime, int> {
  const DatetimeConverterTimestamp();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}
