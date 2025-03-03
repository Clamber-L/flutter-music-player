import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class MainTabViewController extends GetxController with GetSingleTickerProviderStateMixin {
  final state = MainTabViewState();

  MainTabViewController();

  /// 在 widget 内存中分配后立即调用。
  late TabController tabController;
  var selected = 0.obs; // 使用 RxInt 来管理选中的 tab 索引

  @override
  void onInit() {
    super.onInit();
    // 初始化 TabController
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      selected.value = tabController.index; // 使用 Rx 更新 selected 值
    });
  }

  @override
  void onClose() {
    tabController.dispose(); // 销毁 TabController，防止内存泄漏
    super.onClose();
  }
}
