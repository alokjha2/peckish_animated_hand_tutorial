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

// File: lib/src/showcase_widget.dart
// import 'package:flutter/material.dart';
// import 'showcase_controller.dart';
// import 'models/showcase_item.dart';

class ShowcaseTutorial extends StatefulWidget {
  final Widget child;
  final List<ShowcaseItem> items;
  final ShowcaseController? controller;
  final Duration animationDuration;
  final String? handAssetPath;
  final Color? handColor;
  final Widget Function(String tooltip)? tooltipBuilder;
  
  ShowcaseTutorial({
    Key? key,
    required this.child,
    required this.items,
    this.controller,
    this.handColor = Colors.white,
    this.animationDuration = const Duration(seconds: 3),
    this.handAssetPath,
    this.tooltipBuilder,
  }) : super(key: key);

  @override
  _ShowcaseTutorialState createState() => _ShowcaseTutorialState();
}

class _ShowcaseTutorialState extends State<ShowcaseTutorial> with SingleTickerProviderStateMixin {
  late ShowcaseController _controller;
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ShowcaseController();
    _controller.setItems(widget.items);
    
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
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
    super.dispose();
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
                child: Container(
                  height: 50,
                  width: 50,
                  child: 
                  
                  // widget.handAssetPath != null
                  //   ? Image.asset(widget.handAssetPath!)
                    // : 
                    Image.asset(
                      "assets/animated_hand.png",
                      color: widget.handColor, // Change to your desired color
                      colorBlendMode: BlendMode.modulate,
                      )
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