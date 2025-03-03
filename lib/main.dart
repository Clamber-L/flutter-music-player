import 'package:flutter/material.dart';
import 'package:flutter_music_player/pages/splash_view/view.dart';
import 'package:get/get.dart';

import 'common/utils/color_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Circular Std',
        scaffoldBackgroundColor: TColor.bg,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: TColor.primaryText,
          displayColor: TColor.primaryText
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
        useMaterial3: false
      ),
      home: SplashViewPage(),
    );
  }
}