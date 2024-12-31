import 'package:flutter/material.dart';
import 'package:peckish_animated_hand_tutorial/peckish_animated_hand_tutorial.dart';


class ShowcaseItem {
  final GlobalKey key;
  final ToolTip? tooltip;
  final Alignment? handPosition;
  // final Widget? tooltipWidget;

  
  ShowcaseItem({
    required this.key,
    this.tooltip,
    this.handPosition,
    // this.tooltipWidget,
  });
}