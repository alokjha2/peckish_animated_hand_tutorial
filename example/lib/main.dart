import 'package:flutter/material.dart';
import 'package:peckish_animated_hand_tutorial/peckish_animated_hand_tutorial.dart';
// import 'package:showcase_widget/showcase_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  final GlobalKey buttonKey = GlobalKey();
  final GlobalKey textKey = GlobalKey();
  final GlobalKey anotherButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Showcase Example')),
      body: Column(
        children: [
          ShowcaseWidget(
            steps: [
              ShowcaseStep(
                key: buttonKey,
                handPosition: Offset(50, 300),
                descriptionPosition: Offset(20, 350),
                description: 'Tap this button to start.',
              ),
              ShowcaseStep(
                key: textKey,
                handPosition: Offset(100, 500),
                descriptionPosition: Offset(50, 550),
                description: 'This is a highlighted text.',
              ),
              ShowcaseStep(
                key: anotherButtonKey,
                handPosition: Offset(200, 700),
                descriptionPosition: Offset(150, 750),
                description: 'Click this button for more actions.',
              ),
            ],
            onComplete: () {
              print('Showcase completed!');
            },
          ),
          Center(
            key: textKey,
            child: Text('Showcase me!'),
          ),
          ElevatedButton(
            key: buttonKey,
            onPressed: () {
              print('Button pressed!');
            },
            child: Text('Start'),
          ),
          ElevatedButton(
            key: anotherButtonKey,
            onPressed: () {
              print('Another button pressed!');
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}