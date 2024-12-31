import 'package:flutter/material.dart';


class ShowcaseItem {
  final GlobalKey key;
  final String tooltip;
  final Alignment? handPosition;
  // final Widget? tooltipWidget;

  
  ShowcaseItem({
    required this.key,
    required this.tooltip,
    this.handPosition,
    // this.tooltipWidget,
  });
}