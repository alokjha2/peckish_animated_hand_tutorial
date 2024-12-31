import 'package:flutter/material.dart';
import 'package:peckish_animated_hand_tutorial/peckish_animated_hand_tutorial.dart';
import 'package:peckish_animated_hand_tutorial/src/enum.dart';
import 'package:peckish_animated_hand_tutorial/src/models/tool_tip_model.dart';
import 'package:peckish_animated_hand_tutorial/src/models/tool_tip_textstyle.dart';
// import 'package:peckish_animated_hand_tutorial/src/toolTipclass.dart';

class ToolTipWidget extends StatelessWidget {
  final ToolTip toolTip;

  const ToolTipWidget({Key? key, required this.toolTip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: toolTip.toolTipStyle?.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
      //   border: toolTip.toolTipStyle?.border ??
      //       Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Text(
        toolTip.toolTipMessage ?? '', 
        style: TextStyle(color: Colors.black, fontSize: 14),
      //   style: toolTip.toolTipTextStyle?.style ??
      //       TextStyle(fontSize: 14, color: Colors.black), // Apply text styling
      ),
    );
  }
}
