import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class SplashViewPage extends GetView<SplashViewController> {
  const SplashViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return GetBuilder<SplashViewController>(
      init: SplashViewController(),
      id: "splash_view",
      builder: (_) {
        return Center(
          child: Image.asset(
            'assets/img/app_logo.png',
            width: media.width * 0.35,
          ),
        );
      },
    );
  }
}
