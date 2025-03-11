import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final Widget? icon;
  final VoidCallback? onTap;
  final Color? color;
  final double? width;
  final double? height;

  const Button({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.color = Colors.blue,
    this.width = 100,
    this.height = 40,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    Widget body = DefaultTextStyle(
      style: TextStyle(color: Colors.white),
      child: Text(widget.text),
    );
    if (widget.icon != null) {
      body = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(color: Colors.white, size: 18),
            child: widget.icon!,
          ),
          SizedBox(width: 5),
          body,
        ],
      );
    }
    body = Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: widget.color,
        boxShadow: [
          BoxShadow(
            color: widget.color!.withAlpha(100),
            blurRadius: 55,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          _switchStyle();
        },
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          child: body,
        ),
      ),
    );
    return body;
  }

  void _switchStyle() {
    widget.onTap?.call();
  }
}
