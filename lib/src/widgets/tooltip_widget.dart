import 'export_widget.dart';

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
      ),
      child: Text(
        toolTip.toolTipMessage ?? '', 
        style: TextStyle(color: Colors.black, fontSize: 14),

      ),
    );
  }
}