import 'export_widget.dart';


import 'package:flutter/material.dart';

// enum ToolTipType {
//   bubble,
//   simple,
//   cloud,
// }

class ToolTipWidget extends StatelessWidget {
  final ToolTip toolTip;

  const ToolTipWidget({Key? key, required this.toolTip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (toolTip.toolTipType) {
      case ToolTipType.bubble:
        return _buildBubbleTooltip();
      case ToolTipType.simple:
        return _buildSimpleTooltip();
      case ToolTipType.cloud:
        return _buildCloudTooltip();
      default:
        return _buildSimpleTooltip(); 
    }
  }

  Widget _buildBubbleTooltip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: toolTip.toolTipStyle?.backgroundColor ?? Colors.red,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        toolTip.toolTipMessage ?? '',
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }

  Widget _buildSimpleTooltip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: toolTip.toolTipStyle?.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Text(
        toolTip.toolTipMessage ?? '',
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }

  Widget _buildCloudTooltip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: toolTip.toolTipStyle?.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        shape: BoxShape.rectangle,
      ),
      child: CustomPaint(
        painter: CloudBorderPainter(),
        child: Text(
          toolTip.toolTipMessage ?? '',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }
}

class CloudBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height / 2);

    _addCloudBump(path, 0.2, 0.3, 0.1, 0.2);
    _addCloudBump(path, 0.5, 0.6, 0.2, 0.3);
    _addCloudBump(path, 0.8, 0.9, 0.1, 0.2);

    path.lineTo(size.width, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _addCloudBump(Path path, double startRatio, double endRatio,
      double peakHeightRatio, double widthRatio) {
    final double startX = path.getBounds().right;
    final double endX = startX + (startRatio * widthRatio * 100);
    final double controlX = startX + ((endX - startX) / 2);
    final double peakY = -peakHeightRatio * 20;

    path.quadraticBezierTo(
      controlX,
      peakY,
      endX,
      0,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
