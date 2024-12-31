enum ToolTipType {
  bubble,
  simple,
}

class ToolTip {
  final String toolTipMessage;
  final String? toolTipStyle;
  final ToolTipType? toolTipType;
  
  ToolTip({
    required this.toolTipMessage,
    this.toolTipStyle,
    this.toolTipType,
  });
}