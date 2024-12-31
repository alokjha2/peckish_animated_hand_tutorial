
import 'export_models.dart';

class ShowcaseItem {
  final GlobalKey key;
  final ToolTip? tooltip;
  final bool? trigger;
  final Alignment? handAlignment;
  final Function? onAnimationComplete;


  
  ShowcaseItem({
    required this.key,
    this.tooltip,
    this.trigger,
    this.handAlignment,
    this.onAnimationComplete,
  });
}