import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

typedef OnChanged = void Function(SwitcherState switcher, bool value);

class Switcher extends StatefulWidget {
  const Switcher({
    super.key,
    this.width,
    this.height,
    this.toggleSize,
    this.padding,
    required this.value,
    this.disabled = false,
    this.toggleColor,
    this.trackOnColor,
    this.trackOffColor,
    this.onChanged,
    this.onText,
    this.offText,
  });

  /// Initial value
  final bool value;

  /// The given width of the switch.
  ///
  /// Defaults to a width of 52.0.
  final double? width;

  /// The given height of the switch.
  ///
  /// Defaults to a height of 28.0.
  final double? height;

  /// The size of the toggle of the switch.
  ///
  /// Defaults to a size of 20.0.
  final double? toggleSize;

  /// The padding of the switch.
  ///
  /// Defaults to the value of 4.0.
  final double? padding;

  /// Is it disabled?
  final bool disabled;

  /// The color to use on the switch when the switch is on.
  final Color? trackOnColor;

  /// The color to use on the switch when the switch is off.
  final Color? trackOffColor;

  /// The color to use on the toggle of the switch
  final Color? toggleColor;

  /// Called when the user toggles the switch.
  final OnChanged? onChanged;

  /// The text to display when the switch is on.
  /// This parameter is only necessary when [showOnOff] property is true.
  final String? onText;

  /// The text to display when the switch is off.
  /// This parameter is only necessary when [showOnOff] property is true.
  final String? offText;

  @override
  State<Switcher> createState() => SwitcherState();
}

class SwitcherState extends State<Switcher> {
  late bool _value;
  Widget? _icon;
  ProgressIndicator? _progress;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant Switcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: widget.width ?? 40,
      height: widget.height ?? 22,
      disabled: widget.disabled || _icon != null,
      activeIcon: _icon,
      inactiveIcon: _icon,
      toggleSize: widget.toggleSize ?? 16.0,
      value: _value,
      borderRadius: widget.width ?? 42,
      padding: widget.padding ?? 2.0,
      toggleColor: widget.toggleColor ?? Colors.white,
      activeColor: widget.trackOnColor ?? Colors.green,
      inactiveColor: widget.trackOffColor ?? const Color(0xFFDDDDDD),
      showOnOff: widget.onText != null || widget.offText != null,
      valueFontSize: 16,
      activeText: widget.onText,
      inactiveText: widget.offText,
      onToggle: (value) {
        if (!widget.disabled) {
          if (widget.onChanged == null) {
            toggle(value);
          } else {
            widget.onChanged!.call(this, value);
          }
        }
      },
    );
  }

  void finished(bool value) {
    super.setState(() {
      _icon = null;
      _value = value;
    });
  }

  void toggle(bool value) {
    super.setState(() => _value = value);
  }

  void loading() {
    _progress ??= CircularProgressIndicator(
      strokeWidth: 10,
      valueColor: AlwaysStoppedAnimation(widget.trackOnColor),
    );
    super.setState(() => _icon = _progress);
  }
}
