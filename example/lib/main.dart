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

class _ShowcaseScreenState extends State<ShowcaseScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey drawerKey = GlobalKey();
  final GlobalKey appBarKey = GlobalKey();
  final GlobalKey bottomBarKey = GlobalKey();
  final GlobalKey fabKey = GlobalKey();
  final GlobalKey containerKey = GlobalKey();

  Offset currentOffset = Offset.zero;
  List<Offset> positions = [];
  int currentIndex = 0;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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
        _getPositionFromKey(bottomBarKey),
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
      return renderBox.localToGlobal(Offset.zero);
    }
    return Offset.zero;
  }

  void _startAnimationSequence() async {
    for (int i = 0; i < positions.length; i++) {
      _animateToPosition(positions[i]);
      await Future.delayed(_controller.duration!); // Wait for animation to complete
    }
  }

  void _animateToPosition(Offset targetOffset) {
    final Offset startOffset = currentOffset;
    _animation = Tween<Offset>(begin: startOffset, end: targetOffset).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {
          currentOffset = _animation.value;
        });
      });

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        title: Text('Widget Showcase'),
        actions: [
          IconButton(
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
      body: Stack(
        children: [
          Container(
            key: containerKey,
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
                child: Text("Start"),
                onPressed: () {},
              ),
            ),
          ),
          Positioned(
            left: currentOffset.dx,
            top: currentOffset.dy,
            child: Icon(Icons.star, size: 40, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
