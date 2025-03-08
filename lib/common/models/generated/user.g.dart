// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate('User', json, (
  $checkedConvert,
) {
  final val = User(
    id: $checkedConvert('id', (v) => v as String),
    username: $checkedConvert('username', (v) => v as String),
    nickname: $checkedConvert('nickname', (v) => v as String),
    createAt: $checkedConvert(
      'createAt',
      (v) => const DatetimeConverterTimestamp().fromJson((v as num).toInt()),
    ),
  );
  return val;
});

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'nickname': instance.nickname,
  'createAt': const DatetimeConverterTimestamp().toJson(instance.createAt),
};
