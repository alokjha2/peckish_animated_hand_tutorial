import 'package:peckish_animated_hand_tutorial/peckish_animated_hand_tutorial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final GlobalKey buttonKey = GlobalKey();
  final GlobalKey menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PeckishHandTutorial(
        toolTip: const ToolTip(
          toolTipType: ToolTipType.bubble,
          toolTipMessage: "This is a button",
          toolTipStyle: ToolTipStyle(
            backgroundColor: Colors.blue,
            // textColor: Colors.white,
          ),
        ),
        haveRippleEffect: true,
        handColor: Colors.green,
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

