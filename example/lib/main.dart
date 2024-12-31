import 'package:flutter/material.dart';
import 'package:peckish_animated_hand_tutorial/peckish_animated_hand_tutorial.dart';

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

class ShowcaseScreen extends StatelessWidget {
  final GlobalKey buttonKey = GlobalKey();
  final GlobalKey menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowcaseTutorial(
        // handAssetPath: "assets/animated_hand.png",
        items: [
          ShowcaseItem(
            key: buttonKey,
            tooltip: "Click this button to start",
          ),
          ShowcaseItem(
            key: menuKey,
            tooltip: "Access menu options here",
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                key: menuKey,
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
            ],
          ),
          body: Center(
            child: ElevatedButton(
              key: buttonKey,
              onPressed: () {},
              child: Text('Start'),
            ),
          ),
        ),
      ),
    );
  }
}