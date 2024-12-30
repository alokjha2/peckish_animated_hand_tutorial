import 'package:flutter/material.dart';

// A simple animated hand widget
class PeckishAnimatedHand extends StatefulWidget {
  @override
  _PeckishAnimatedHandState createState() => _PeckishAnimatedHandState();
}

class _PeckishAnimatedHandState extends State<PeckishAnimatedHand> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true); // Repeat the animation
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            height: 100,
            width: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              'Hand: ${_animation.value.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// A utility function that can be used in the main app or in the example
String getGreeting() {
  return 'Hello, Peckish World!';
}
