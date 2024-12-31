library peckish_animated_hand_tutorial;

import 'package:flutter/material.dart';
import 'package:peckish_animated_hand_tutorial/src/enum.dart';
import 'package:peckish_animated_hand_tutorial/src/models/tool_tip_style.dart';
// import 'package:peckish_animated_hand_tutorial/src/models/tool_tip_model.dart';
import 'package:peckish_animated_hand_tutorial/src/models/tool_tip_textstyle.dart';

class ToolTip {
  final String? toolTipMessage; 
  final ToolTipType? toolTipType;
  final Function? onTooltipTap;
  final ToolTipStyle? toolTipStyle;
  final Alignment? toolTipAlignment;
  final ToolTipTextStyle? toolTipTextStyle;
  
  const ToolTip({ 
    this.toolTipMessage,  
    this.toolTipType,
    this.toolTipAlignment,
    this.onTooltipTap,
    this.toolTipStyle,
    this.toolTipTextStyle,
  });
}
