import 'package:get/get.dart';

import 'controller.dart';

class MainTabViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabViewController>(() => MainTabViewController());
  }
}
