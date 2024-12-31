library peckish_animated_hand_tutorial;

import 'package:peckish_animated_hand_tutorial/src/enum.dart';
import 'package:peckish_animated_hand_tutorial/src/models/tool_tip_model.dart';
import 'package:peckish_animated_hand_tutorial/src/models/tool_tip_textstyle.dart';
// export 'toolTipClass.dart'; 

class ToolTip {
  final String? toolTipMessage;  // Make nullable
  final ToolTipType? toolTipType;
  final Function? onTooltipTap;
  final ToolTipStyle? toolTipStyle;
  final ToolTipTextStyle? toolTipTextStyle;
  
  const ToolTip({  // Add const constructor
    this.toolTipMessage,  // Make parameter optional
    this.toolTipType,
    this.onTooltipTap,
    this.toolTipStyle,
    this.toolTipTextStyle,
  });
}
