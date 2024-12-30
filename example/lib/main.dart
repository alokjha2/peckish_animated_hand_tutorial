import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowcaseScreen(),
    );
  }
}

class ShowcaseScreen extends StatefulWidget {
  @override
  _ShowcaseScreenState createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<ShowcaseScreen> with SingleTickerProviderStateMixin {
  final GlobalKey drawerKey = GlobalKey();
  final GlobalKey appBarKey = GlobalKey();
  final GlobalKey bottomBarKey = GlobalKey();
  final GlobalKey fabKey = GlobalKey();
  final GlobalKey containerKey = GlobalKey();

  Offset currentOffset = Offset.zero;
  List<Offset> positions = [];
  List<String> tooltips = ["Drawer Tooltip", "AppBar Tooltip", "FAB Tooltip", "Start Button Tooltip"];
  bool showTooltip = false; // Track if tooltip should be shown
  String currentTooltipText = ''; // Store the current tooltip text

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getWidgetPositions();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getWidgetPositions() {
    setState(() {
      positions = [
        _getPositionFromKey(drawerKey),
        _getPositionFromKey(appBarKey),
        _getPositionFromKey(fabKey),
        _getPositionFromKey(containerKey),
      ];
    });

    if (positions.isNotEmpty) {
      _startAnimationSequence();
    }
  }

  Offset _getPositionFromKey(GlobalKey key) {
    if (key.currentContext == null) {
      return Offset.zero;
    }
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      Offset position = renderBox.localToGlobal(Offset.zero);
      return Offset(position.dx, position.dy + 20); // Adjust position if needed
    }
    return Offset.zero;
  }

  void _startAnimationSequence() async {
    for (int i = 0; i < positions.length; i++) {
      _animateToPosition(positions[i], i);
      await Future.delayed(_controller.duration!); // Wait for animation to complete
    }
  }

  void _animateToPosition(Offset targetOffset, int index) {
    final Offset startOffset = currentOffset;
    _animation = Tween<Offset>(begin: startOffset, end: targetOffset).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {
          currentOffset = _animation.value;

          // Check if the hand has reached the target position
          double tolerance = 10.0; // Allow small tolerance for reaching the target
          if ((currentOffset.dx - targetOffset.dx).abs() < tolerance && 
              (currentOffset.dy - targetOffset.dy).abs() < tolerance) {
            // If the hand is near the target position, show the tooltip
            currentTooltipText = tooltips[index];
            showTooltip = true;
          }
        });
      });

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Widget Showcase'),
            actions: [
              IconButton(
                key: appBarKey,
                icon: Icon(Icons.arrow_forward),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.crop_square_sharp),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ],
          ),
          drawer: Drawer(
            key: drawerKey,
            child: ListView(
              children: [
                DrawerHeader(child: Text('Drawer Content')),
                ListTile(title: Text('Item 1')),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            key: fabKey,
            onPressed: () {
              _getWidgetPositions();
            },
            child: Icon(Icons.play_arrow),
          ),
          body: Container(
            height: 600,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.orange.shade300,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: TextButton(
                key: containerKey,
                child: Text("Start"),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Positioned(
          left: currentOffset.dx,
          top: currentOffset.dy,
          child: Container(
            height: 50,
            width: 50,
            child: Image.asset("assets/animated_hand.png"),
          ),
        ),
        if (showTooltip) // Show tooltip when condition is met
          Positioned(
            left: currentOffset.dx + 20,
            top: currentOffset.dy + 60,  // Adjust position above hand
            child: Container(
              height: 30,
              width: 160,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                currentTooltipText,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ),
      ],
    );
  }
}
