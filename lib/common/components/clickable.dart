import 'package:flutter/material.dart';
import 'package:flutter_music_player/common/components/clickable_gesture_detector.dart';

class Clickable extends StatefulWidget {
  final Widget? child;
  final bool disabled;
  final ValueGetter<Widget>? builder;
  final bool clickable;
  final double? width;
  final double? height;
  final Border? border;
  final Color? backgroundColor;
  final BoxConstraints? constraints;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final HitTestBehavior? behavior;

  const Clickable({
    super.key,
    this.child,
    this.builder,
    this.disabled = false,
    this.clickable = true,
    this.width,
    this.height,
    this.constraints,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.alignment,
    this.padding,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.behavior = HitTestBehavior.translucent,
  });

  @override
  State<StatefulWidget> createState() => _ClickableState();
}

class _ClickableState extends State<Clickable> {
  static const pressedAlpha = 240, normalAlpha = 255, disabledAlpha = 100;

  int _alpha = normalAlpha;
  late bool _disabled;

  void _change(bool active) {
    setState(() => _alpha = active ? pressedAlpha : normalAlpha);
  }

  @override
  void initState() {
    super.initState();
    _disabled = widget.disabled;
  }

  @override
  void didUpdateWidget(covariant Clickable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.disabled != widget.disabled) {
      _disabled = widget.disabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.backgroundColor ?? Colors.white;
    final bgColor = color.withAlpha(_disabled ? disabledAlpha : _alpha);
    final Widget wrapper = Container(
      padding: widget.padding,
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: bgColor,
        border: widget.border,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
      ),
      alignment: widget.alignment,
      constraints: widget.constraints,
      child: widget.child ?? widget.builder?.call(),
    );

    if (_disabled || !widget.clickable) {
      return wrapper;
    }

    return ClickableGestureDetector(
      onHandle: _change,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: wrapper,
    );
  }
}
