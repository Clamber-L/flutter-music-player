import 'package:flutter/material.dart';
import 'package:flutter_music_player/pages/main_tab_view/controller.dart';
import 'package:get/get.dart';

class MainTabViewPage extends StatelessWidget {
  MainTabViewPage({super.key});
  final MainTabViewController controller = Get.put(MainTabViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller.tabController,
        children: [
          Container(color: Colors.red),
          Container(color: Colors.green),
          Container(color: Colors.blue),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Obx(() {
          return TabBar(
            controller: controller.tabController,
            tabs: [
              BarIcon(
                "Home",
                controller,
                0,
                'assets/img/home_tab.png',
                'assets/img/home_tab_un.png',
              ),
              BarIcon(
                "Songs",
                controller,
                1,
                'assets/img/songs_tab.png',
                'assets/img/songs_tab_un.png',
              ),
              BarIcon(
                "Settings",
                controller,
                2,
                'assets/img/setting_tab.png',
                'assets/img/setting_tab_un.png',
              ),
            ],
          );
        }),
      ),
    );
  }
}

Widget BarIcon(
  String text,
  MainTabViewController controller,
  int index,
  String tabImg,
  String unTabImg,
) {
  return Tab(
    text: text,
    icon: Image.asset(
      controller.selected.value == index ? tabImg : unTabImg,
      width: 25,
      height: 25,
    ),
  );
}
