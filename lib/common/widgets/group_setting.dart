import 'package:flutter/material.dart';
import 'package:flutter_music_player/common/components/clickable.dart';

import '../components/switcher.dart';

class GroupSetting extends StatelessWidget {
  final List<Item> children;
  final double vSpacing;
  final double hSpacing;
  final EdgeInsets boxInsets;

  GroupSetting({
    super.key,
    required this.children,
    this.vSpacing = 14,
    this.hSpacing = 14,
  }) : boxInsets = EdgeInsets.symmetric(
         vertical: vSpacing,
         horizontal: hSpacing,
       );

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        // 提供上下回弹效果
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: ListView.builder(
          // 由于SingleChildScrollView提供回弹效果 所以需要将ListView的回弹效果取消
          physics: const NeverScrollableScrollPhysics(),
          itemCount: children.length,
          shrinkWrap: true,
          // 分割线取消
          addRepaintBoundaries: false,

          itemBuilder: (context, index) {
            Item item = children[index];
            Widget widget = item.build(this, context);
            return widget;
          },
        ),
      ),
    );
  }
}

abstract class Item {
  Widget build(GroupSetting widget, BuildContext context);

  static Item customize(Widget child) => _ItemCustomize(child);

  static Item spacer([double space = 10]) => _ItemSpacer(space);

  static Item leading(String leading) => _ItemLeading(leading);

  static Item text({
    Widget? icon,
    required String title,
    String? subtitle,
    String? description,
  }) => _ItemText(
    icon: icon,
    title: title,
    subtitle: subtitle,
    description: description,
  );

  static Item switcher({
    Widget? icon,
    required String title,
    String? subtitle,
    String? description,
    bool value = false,
    OnChanged? onChanged,
  }) => _ItemSwitcher(
    title: title,
    subtitle: subtitle,
    icon: icon,
    description: description,
    value: value,
    onChanged: onChanged,
  );

  static Item notification({
    Widget? icon,
    required String title,
    String? subtitle,
    String? description,
    VoidCallback? onTap,
    Type? goto,
  }) => _ItemNotification(
    title: title,
    subtitle: subtitle,
    icon: icon,
    description: description,
    onTap: onTap,
    goto: goto,
  );
}

abstract class _ItemCommon extends Item {
  // 图标
  final Widget? icon;
  //主标题
  final String title;
  //子标题
  final String? subtitle;
  // 描述文本
  final String? description;
  //是否显示右箭头
  final bool? arrow;
  // onTap | goto 二选一
  final VoidCallback? onTap;
  // 一般设置项都是仅跳转，所以添加一个快捷方式
  final Type? goto;

  _ItemCommon({
    this.icon,
    required this.title,
    this.subtitle,
    this.description,
    this.arrow = true,
    this.onTap, // 用于处理点击事件的回调
    this.goto, // 当内容项仅跳转页面时，可以使用此属性设置路由跳转地址
  }) : assert(icon == null || icon is Icon || icon is Image);

  Widget? ending(GroupSetting widget, BuildContext context) => null;

  @override
  Widget build(GroupSetting widget, BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> items = <Widget>[];

    Widget? imageIcon;
    if (icon != null) {
      if (icon is Image) {
        imageIcon = Image(image: (icon as Image).image, width: 32, height: 32);
      } else if (icon is Icon) {
        imageIcon = IconTheme(
          data: theme.iconTheme.copyWith(size: 32, color: Colors.blue),
          child: icon as Icon,
        );
      }
    }

    if (imageIcon != null) {
      items.add(Padding(padding: widget.boxInsets, child: imageIcon));
    }

    // 主标题
    Widget caption = Text(
      title,
      style: TextStyle(fontSize: 14, color: Colors.black),
      strutStyle: StrutStyle(leading: 0, forceStrutHeight: true),
    );

    //子标题
    if (subtitle?.isNotEmpty ?? false) {
      caption = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          caption,
          Text(
            subtitle!,
            style: TextStyle(fontSize: 12, color: Colors.grey),
            strutStyle: StrutStyle(leading: 0, forceStrutHeight: true),
          ),
        ],
      );
    }
    if (imageIcon == null) {
      caption = Padding(
        padding: EdgeInsets.all(widget.boxInsets.left),
        child: caption,
      );
    }

    items.add(Expanded(child: caption));

    //描述信息
    if (description?.isNotEmpty ?? false) {
      items.add(
        Text(
          description!,
          style: TextStyle(fontSize: 14, color: Colors.grey),
          strutStyle: StrutStyle(leading: 0, forceStrutHeight: true),
        ),
      );
    }
    // 尾部小组件
    final endWidget = ending(widget, context);
    if (endWidget != null) {
      items.add(endWidget);
    }

    //显示右箭头
    if (arrow!) {
      items.add(
        Padding(
          padding: const EdgeInsets.all(2.0).copyWith(left: 0),
          child: Icon(Icons.chevron_right, size: 22, color: Colors.grey),
        ),
      );
    }

    return Clickable(
      onTap: onTap,
      border: Border(bottom: BorderSide(color: Colors.black)),
      backgroundColor: Colors.white,
      child: Row(mainAxisSize: MainAxisSize.max, children: items),
    );
  }
}

// 自定义内容
class _ItemCustomize extends Item {
  final Widget child;

  _ItemCustomize(this.child);

  @override
  Widget build(GroupSetting widget, BuildContext context) => child;
}

// 分割线 默认高度10
class _ItemSpacer extends Item {
  final double space;

  _ItemSpacer(this.space);

  @override
  Widget build(GroupSetting widget, BuildContext context) {
    return SizedBox(height: space);
  }
}

// 文本
class _ItemLeading extends Item {
  final String leading;

  _ItemLeading(this.leading);

  @override
  Widget build(GroupSetting widget, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(
        leading,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }
}

// 自定义多行内容文本
class _ItemText extends _ItemCommon {
  _ItemText({
    super.icon,
    required super.title,
    super.subtitle,
    super.description,
  });
}

class _ItemSwitcher extends _ItemCommon {
  // 状态开关的初始值（ture：打开，false：关闭）
  final bool value;
  // 状态切换回调
  final OnChanged? onChanged;

  _ItemSwitcher({
    super.icon,
    required super.title,
    super.subtitle,
    super.description,
    this.value = false,
    this.onChanged,
  }) : super(arrow: false); // arrow 为 false 即不显示右侧箭头

  @override
  Widget? ending(GroupSetting widget, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: widget.boxInsets.right),
      // Switcher 是我基于 flutter_switch 组件进行二次封装的一个组件
      // 贴在文末的，放在前面影响整体逻辑，望知晓~
      child: Switcher(value: value, onChanged: onChanged),
    );
  }
}

class _ItemNotification extends _ItemCommon {
  _ItemNotification({
    super.icon,
    required super.title,
    super.subtitle,
    super.description,
    super.onTap,
    super.goto,
  });

  @override
  Widget? ending(GroupSetting widget, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.boxInsets.left),
      child: const Badge(
        label: Text("NEW", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
