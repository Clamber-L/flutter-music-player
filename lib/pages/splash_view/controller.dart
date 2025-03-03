import 'package:flutter_music_player/pages/main_tab_view/view.dart';
import 'package:get/get.dart';

class SplashViewController extends GetxController {
  SplashViewController();

  void loadView() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => MainTabViewPage());
  }

  _initData() {
    update(["splash_view"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
    loadView();
  }
}
