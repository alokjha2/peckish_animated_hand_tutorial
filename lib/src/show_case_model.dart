import 'package:flutter/material.dart';
import 'package:peckish_animated_hand_tutorial/peckish_animated_hand_tutorial.dart';


class ShowcaseItem {
  final GlobalKey key;
  final ToolTip? tooltip;
  final Alignment? handAlignment;
  // final Widget? tooltipWidget;

  
  ShowcaseItem({
    required this.key,
    this.tooltip,
    this.handAlignment,
    // this.tooltipWidget,
  });
}