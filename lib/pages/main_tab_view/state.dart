import 'package:get/get.dart';

class MainTabViewState {
  Rx<int> selected = 0.obs; // 使用 RxInt 来管理选中的 tab 索引

  var text = "我是测试按钮";
}
