import 'package:flutter/material.dart';

class ClickableGestureDetector extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onLongPress;
  final ValueChanged<bool> onHandle;
  final HitTestBehavior? behavior;

  const ClickableGestureDetector({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    required this.onHandle,
    this.behavior = HitTestBehavior.translucent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: behavior,
      onTapDown: (details) => onHandle.call(true),
      onTapCancel: () => onHandle.call(false),
      onTapUp: (details) {
        Future.delayed(const Duration(milliseconds: 100), () {
          onHandle.call(false);
          onTap?.call();
        });
      },
      onLongPressStart: (details) {
        onHandle.call(true);
        onLongPress?.call(true);
      },
      onLongPressEnd: (details) {
        onHandle.call(false);
        Future.delayed(const Duration(milliseconds: 100), () {
          onHandle.call(false);
          onLongPress?.call(false);
        });
      },
      child: child,
    );
  }
}
