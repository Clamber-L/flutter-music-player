import 'package:get/get.dart';

import 'controller.dart';

class MainTabViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabViewController>(() => MainTabViewController());
  }
}
