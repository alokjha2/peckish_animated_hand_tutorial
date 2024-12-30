import 'package:flutter/material.dart';

import 'package:peckish_animated_hand_tutorial/peckish_animated_hand_tutorial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: PeckishAnimatedHand(),  // Example usage of the widget
        ),
      ),
    );
  }
}
