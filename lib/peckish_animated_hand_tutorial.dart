// File: lib/showcase_tutorial.dart
library showcase_tutorial;

import 'package:flutter/material.dart';
import 'package:peckish_animated_hand_tutorial/src/show_case_model.dart';

// export 'src/showcase_controller.dart';
// export 'src/showcase_widget.dart';
export 'src/show_case_model.dart';

// File: lib/src/models/showcase_item.dart


// File: lib/src/showcase_controller.dart

class ShowcaseController extends ChangeNotifier {
  final List<ShowcaseItem> _items = [];
  bool _isPlaying = false;
  int _currentIndex = 0;
  Offset _currentOffset = Offset.zero;
  bool _showTooltip = false;
  
  List<ShowcaseItem> get items => _items;
  bool get isPlaying => _isPlaying;
  Offset get currentOffset => _currentOffset;
  bool get showTooltip => _showTooltip;
  String get currentTooltip => _currentIndex < _items.length ? _items[_currentIndex].tooltip : '';
  
  void addItem(ShowcaseItem item) {
    _items.add(item);
    notifyListeners();
  }
  
  void setItems(List<ShowcaseItem> items) {
    _items
      ..clear()
      ..addAll(items);
    notifyListeners();
  }
  
  void updateOffset(Offset offset) {
    _currentOffset = offset;
    notifyListeners();
  }
  
  void setShowTooltip(bool show) {
    _showTooltip = show;
    notifyListeners();
  }
  
  void next() {
    if (_currentIndex < _items.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }
  
  void reset() {
    _currentIndex = 0;
    _showTooltip = false;
    _currentOffset = Offset.zero;
    notifyListeners();
  }
}



class ShowcaseTutorial extends StatefulWidget {
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
  final Widget Function(String tooltip)? tooltipBuilder;
  
  ShowcaseTutorial({
    Key? key,
    required this.child,
    required this.items,
    this.controller,
    this.handSize = 50,
    this.handColor = Colors.white,
    this.animationDuration = const Duration(seconds: 3),
    this.handAssetPath,
    this.initialDelay,
    this.onAnimationComplete,
    this.tooltipBuilder,
    this.triggerWhen,
    this.haveRippleEffect = false,
  }) : super(key: key);

  @override
  _ShowcaseTutorialState createState() => _ShowcaseTutorialState();
}

class _ShowcaseTutorialState extends State<ShowcaseTutorial> with TickerProviderStateMixin {
  late ShowcaseController _controller;
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late AnimationController _rippleController;
  late Animation<double> _rippleSizeAnimation;
  late Animation<double> _rippleOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ShowcaseController();
    _controller.setItems(widget.items);

    // Initialize animation controllers
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Ripple effect animations
    _rippleSizeAnimation = Tween<double>(begin: 0, end: 90).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _rippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getWidgetPositions();
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

  void _getWidgetPositions() {
    if (_controller.items.isEmpty) return;
    _startAnimationSequence();
  }

  Offset _getPositionFromKey(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return Offset.zero;

    final position = renderBox.localToGlobal(Offset.zero);
    return Offset(position.dx, position.dy + 20);
  }

  void _startAnimationSequence() async {
    for (int i = 0; i < _controller.items.length; i++) {
      final targetOffset = _getPositionFromKey(_controller.items[i].key);
      await _animateToPosition(targetOffset);
      _triggerRipple();
      await Future.delayed(_animationController.duration!);
    }
  }

  Future<void> _animateToPosition(Offset targetOffset) async {
    final startOffset = _controller.currentOffset;
    _animation = Tween<Offset>(
      begin: startOffset,
      end: targetOffset,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      _controller.updateOffset(_animation.value);

      const tolerance = 10.0;
      if ((_animation.value.dx - targetOffset.dx).abs() < tolerance &&
          (_animation.value.dy - targetOffset.dy).abs() < tolerance) {
        _controller.setShowTooltip(true);
      }
    });

    await _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
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
                        widget.handAssetPath ?? "assets/animated_hand.png",
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
                  left: _controller.currentOffset.dx + 20,
                  top: _controller.currentOffset.dy + 60,
                  child: widget.tooltipBuilder?.call(_controller.currentTooltip) ??
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _controller.currentTooltip,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
