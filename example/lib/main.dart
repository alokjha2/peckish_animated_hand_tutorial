import 'dart:async';

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

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey buttonKey = GlobalKey();

  final GlobalKey menuKey = GlobalKey();
  //  late Function? triggerTutorial;

  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 10), () {
    //   if (triggerTutorial != null) {
    //     triggerTutorial!();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {

    return PeckishHandTutorial(
      initiallyHide: false,
// triggerWhen: (trigger) {
//          triggerTutorial = trigger;
//       },
      initialAlignment: Alignment.topCenter,
        toolTip: const ToolTip(
          toolTipType: ToolTipType.bubble,
          toolTipMessage: "This is a button",
          toolTipStyle: ToolTipStyle(
            backgroundColor: Colors.blue,
          ),
        ),
        haveRippleEffect: true,
        handColor: Colors.green,
        items: [
          ShowcaseItem(

            key: buttonKey,
            tooltip: const ToolTip(toolTipMessage: "button"),
          ),
          ShowcaseItem(
            key: menuKey,
            tooltip: const ToolTip(
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
      
    );
  }
}

