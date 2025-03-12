import 'package:flutter_music_player/common/index.dart';

class UserApi extends BaseApi<User> {
  UserApi() : super(User.fromJson, prefix: "/flutter");

  Future<User> getOne() {
    return api.get("$prefix/one");
  }

  Future<List<User>> getAllUsers() {
    return api.getList("$prefix/all");
  }
}
