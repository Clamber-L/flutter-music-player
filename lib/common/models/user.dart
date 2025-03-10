import 'package:flutter_music_player/common/utils/converter/datetime_converter.dart';
import 'package:flutter_music_player/common/utils/result/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/user.g.dart';

@JsonSerializable(converters: [DatetimeConverterTimestamp()])
class User extends Model<User> {
  final String id;
  final String username;
  final String nickname;
  final DateTime createAt;

  const User({
    required this.id,
    required this.username,
    required this.nickname,
    required this.createAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
