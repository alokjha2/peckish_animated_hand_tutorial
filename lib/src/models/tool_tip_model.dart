import 'package:flutter/material.dart';

class ToolTipStyle {
  final Color backgroundColor;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool enableBorder;

  const ToolTipStyle({
    this.backgroundColor = Colors.white,
    this.alignment = Alignment.bottomCenter,
    this.padding = const EdgeInsets.all(8.0),
    this.enableBorder = false,
  });
}
