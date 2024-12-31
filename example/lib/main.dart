import 'package:flutter/material.dart';
// import 'package:peckish_animated_hand_tutorial/peckish_animated_hand_tutorial.dart';
// import 'package:peckish_animated_hand_tutorial/src/tooltipclass.dart'; // Fixed casing
// import 'package:peckish_animated_hand_tutorial/src/enum.dart';
// import 'package:peckish_animated_hand_tutorial/src/models/tool_tip_model.dart';
// import 'package:peckish_animated_hand_tutorial/export.dart';
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
        haveRippleEffect: true,
        handColor: Colors.blue,
        items: [
          ShowcaseItem(

            key: buttonKey,
            tooltip: ToolTip(toolTipMessage: "button"),
          ),
          ShowcaseItem(
            key: menuKey,
            tooltip: ToolTip(
              toolTipType: ToolTipType.bubble,
              toolTipMessage: "drawer", toolTipStyle: ToolTipStyle()),
            // tooltip: "Access menu options here",
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

