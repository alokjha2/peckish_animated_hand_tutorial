import 'export_models.dart';


class PeckishHandTutorialModel {
  final Widget child;
  final List<ShowcaseItem> items;
  final ShowcaseController? controller;
  final Duration animationDuration;
  final String? handAssetPath;
  final double? handSize;
  final Duration? initialDelay;
  final Color? handColor;
  final bool? haveRippleEffect;
  final Function? onAnimationComplete;
  final Function? triggerWhen;
  final ToolTip toolTip;
  final Widget Function(String tooltip)? tooltipBuilder;

  PeckishHandTutorialModel({
    required this.child,
    required this.items,
    this.controller,
    this.handSize = 50,
    this.handColor = Colors.white,
    this.animationDuration = const Duration(seconds: 3),
    this.handAssetPath,
    this.toolTip = const ToolTip(),
    this.initialDelay,
    this.onAnimationComplete,
    this.tooltipBuilder,
    this.triggerWhen,
    this.haveRippleEffect = false,
  });
}
