import 'export.dart';
import 'package:logger/logger.dart';
export "export.dart";

class PeckishHandTutorial extends StatefulWidget {
  final Widget child;
  final List<ShowcaseItem> items;
  final ShowcaseController? controller;
  final Duration animationDuration;
  final String? handAssetPath;
  final double? handSize;
  final Duration? initialDelay;
  final Color? handColor;
  final bool? haveRippleEffect;
  final bool? loop;
  final Function? onAnimationComplete;
  final Function(Function)? triggerWhen;
  final Alignment? initialAlignment;
  final bool? initiallyHide;

  final ToolTip toolTip;
  final Widget Function(String tooltip)? tooltipBuilder;

  PeckishHandTutorial({
    Key? key,
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
    this.loop = false,
    this.initiallyHide = false,
    this.initialAlignment = Alignment.bottomRight,
  }) : assert(
          !(initiallyHide == true && triggerWhen == null),
          'triggerWhen must be provided when initiallyHide is true.',
        ),
        super(key: key);

  @override
  _PeckishHandTutorialState createState() => _PeckishHandTutorialState();
}


class _PeckishHandTutorialState extends State<PeckishHandTutorial> with TickerProviderStateMixin {
  late ShowcaseController _controller;
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late AnimationController _rippleController;
  late Animation<double> _rippleSizeAnimation;
  late Animation<double> _rippleOpacityAnimation;
   bool _isTutorialActive = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ShowcaseController();
    _controller.setItems(widget.items);

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _rippleSizeAnimation = Tween<double>(begin: 1, end: 90).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _rippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    

  void _startTutorial() {
    if (_isTutorialActive) return;
    setState(() {
      _isTutorialActive = true;
    });
    _getWidgetPositions();
  }

    if (!widget.initiallyHide!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startTutorial();
      });
    }

   widget.triggerWhen?.call(() {
      _startTutorial();
    });
  }

  

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _animationController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _triggerRipple() {
    _rippleController.forward(from: 0);
  }

Offset _clampToBounds(Offset offset, Size screenSize, double handSize) {
  final clampedX = offset.dx.clamp(0.0, screenSize.width - handSize*1.3);
  final clampedY = offset.dy.clamp(0.0, screenSize.height - handSize*1.5);
  return Offset(clampedX, clampedY);
}


  Offset _getOffsetFromAlignment(Alignment alignment, Size screenSize) {
  final dx = (alignment.x + 1) / 2 * screenSize.width;
  final dy = (alignment.y + 1) / 2 * screenSize.height;
  return Offset(dx, dy);
}


  void _getWidgetPositions() {
    if (_controller.items.isEmpty) return;
    _startAnimationSequence();
  }

Offset _getPositionFromKey(GlobalKey key) {
  final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox == null) return Offset.zero;

  final position = renderBox.localToGlobal(Offset.zero);
  final handSize = widget.handSize ?? 50.0;

  final screenSize = MediaQuery.of(context).size;
  return _clampToBounds(
    Offset(position.dx, position.dy + 20),
    screenSize,
    handSize,
  );
}


void _startAnimationSequence() async {
  final screenSize = MediaQuery.of(context).size;
  final handSize = widget.handSize ?? 50.0;

  final initialPosition = _clampToBounds(
    _getOffsetFromAlignment(widget.initialAlignment!, screenSize),
    screenSize,
    handSize,
  );

  _controller.updateOffset(initialPosition); 

  for (int i = 0; i < _controller.items.length; i++) {
    final targetOffset = _getPositionFromKey(_controller.items[i].key);
    await _animateToPosition(targetOffset);
    _triggerRipple();
    await Future.delayed(_animationController.duration!);
  }

    Logger().wtf("completed!");
     setState(() {
      _isTutorialActive = false;
    });
}



Future<void> _animateToPosition(Offset targetOffset) async {
  final screenSize = MediaQuery.of(context).size;
  final handSize = widget.handSize ?? 50.0;

  final startOffset = _controller.currentOffset;
  final clampedTargetOffset = _clampToBounds(targetOffset, screenSize, handSize);

  _animation = Tween<Offset>(
    begin: startOffset,
    end: clampedTargetOffset,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ),
  )..addListener(() {
      _controller.updateOffset(_animation.value);

      const tolerance = 10.0;
      if ((_animation.value.dx - clampedTargetOffset.dx).abs() < tolerance &&
          (_animation.value.dy - clampedTargetOffset.dy).abs() < tolerance) {
        _controller.setShowTooltip(true);
      }
    });
  await _animationController.forward(from: 0);
  // Logger().wtf("completed!");
}

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print('Screen Size: $screenSize');

    return Material(
      child: Stack(
        children: [
          widget.child,
          if (_isTutorialActive)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Stack(
              children: [
                Positioned(
                  left: _controller.currentOffset.dx,
                  top: _controller.currentOffset.dy,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (widget.haveRippleEffect!)
                        AnimatedBuilder(
                          animation: _rippleController,
                          builder: (context, child) {
                            return Container(
                              width: _rippleSizeAnimation.value,
                              height: _rippleSizeAnimation.value,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.handColor?.withOpacity(_rippleOpacityAnimation.value),
                              ),
                            );
                          },
                        ),
                      SizedBox(
                              width: widget.handSize,
                              height: widget.handSize,
                              child: Image.asset(
                                widget.handAssetPath ?? 
                                'packages/peckish_animated_hand_tutorial/assets/animated_hand.png',
                                color: widget.handColor,
                                colorBlendMode: BlendMode.modulate,
                                fit: BoxFit.cover,
                              ),
                            ),
      
                    ],
                  ),
                ),
               if (_controller.showTooltip)
     Positioned(
  left: _clampToBounds(
    Offset(_controller.currentOffset.dx + 20, 0),
    screenSize,
    widget.handSize!,
  ).dx,
  top: _clampToBounds(
    Offset(0, _controller.currentOffset.dy + 60),
    screenSize,
    widget.handSize!,
  ).dy,
  child: widget.tooltipBuilder?.call(_controller.currentTooltip.toolTipMessage!) ?? 
         ToolTipWidget(toolTip: _controller.currentTooltip),
),

      
              ],
            ),
          ),
        ],
      ),
    );
  }
}
