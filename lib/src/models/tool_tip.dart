import 'export_models.dart';

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
