import 'package:flutter/material.dart';
import 'package:flutter_music_player/pages/main_tab_view/controller.dart';
import 'package:get/get.dart';

class TabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainTabViewController controller = Get.put(MainTabViewController());

    return Scaffold(
      body: TabBarView(
        children: [Container(color: Colors.red), Container(color: Colors.green), Container(color: Colors.blue)],
        controller: controller.tabController,
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(
              text: 'Home',
              icon: Image.asset(controller.selected.value == 0 ? 'assets/img/home_tab.png' : 'assets/img/home_tab_un.png', width: 25, height: 25),
            ),
            Tab(
              text: 'Songs',
              icon: Image.asset(controller.selected.value == 1 ? 'assets/img/songs_tab.png' : 'assets/img/songs_tab_un.png', width: 25, height: 25),
            ),
            Tab(
              text: 'Settings',
              icon: Image.asset(controller.selected.value == 2 ? 'assets/img/setting_tab.png' : 'assets/img/setting_tab_un.png', width: 25, height: 25),
            ),
          ],
        ),
      ),
    );
  }
}
