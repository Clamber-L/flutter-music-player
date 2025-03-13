import 'package:flutter/material.dart';
import 'package:flutter_music_player/common/index.dart';
import 'package:flutter_music_player/common/widgets/group_setting.dart';
import 'package:flutter_music_player/pages/home_page/view.dart';
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
          HomePage(),
          SafeArea(
            child: GetBuilder<MainTabViewController>(
              builder: (logic) {
                return Center(
                  child: Button(
                    width: 300,
                    color: Colors.purple,
                    text: controller.state.text,
                    icon: Icon(Icons.home),
                    onTap: () {
                      controller.oneUser();
                    },
                  ),
                );
              },
            ),
          ),
          GroupSetting(
            children: <Item>[
              Item.leading("hello world"),
              Item.customize(
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  color: Colors.blue,
                  child: Text("第一项自定义"),
                ),
              ),
              Item.spacer(10),
              Item.text(
                title: "账号与安全",
                icon: Icon(Icons.tiktok),
                subtitle: "账号与安全子标题",
                description: "这里是描述信息",
              ),
              Item.switcher(title: "switcher"),
              Item.spacer(),
              Item.notification(
                title: "notification",
                onTap: () => Get.snackbar("title", "message"),
              ),
            ],
          ),
          // StatusView(
          //   retry: controller.loading,
          //   controller: controller.statusViewController,
          //   status: Status.NETWORK_ERROR,
          //   builder:
          //       (context) => const Center(
          //     child: Text("测试页面", style: TextStyle(color: Colors.blue)),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: TColor.bg,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomAppBar(
          height: 60,
          color: Colors.transparent,
          elevation: 0,
          child: Obx(() {
            return TabBar(
              controller: controller.tabController,
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: TColor.primary,
              labelStyle: const TextStyle(fontSize: 10),
              unselectedLabelColor: TColor.unfocused,
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              tabs: [
                _barIcon(
                  "Home",
                  controller,
                  0,
                  'assets/img/home_tab.png',
                  'assets/img/home_tab_un.png',
                ),
                _barIcon(
                  "Songs",
                  controller,
                  1,
                  'assets/img/songs_tab.png',
                  'assets/img/songs_tab_un.png',
                ),
                _barIcon(
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
      ),
    );
  }
}

Widget _barIcon(
  String text,
  MainTabViewController controller,
  int index,
  String tabImg,
  String unTabImg,
) {
  return Tab(
    text: text,
    icon: Image.asset(
      controller.state.selected.value == index ? tabImg : unTabImg,
      width: 18,
      height: 18,
    ),
  );
}
