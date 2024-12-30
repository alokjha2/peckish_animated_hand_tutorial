import 'package:flutter/material.dart';


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

class _ShowcaseScreenState extends State<ShowcaseScreen> {
  final GlobalKey drawerKey = GlobalKey();
  final GlobalKey appBarKey = GlobalKey();
  final GlobalKey bottomBarKey = GlobalKey();
  final GlobalKey fabKey = GlobalKey();
  final GlobalKey containerKey = GlobalKey();

  Offset drawerPosition = Offset.zero;
  Offset appBarPosition = Offset.zero;
  Offset bottomBarPosition = Offset.zero;
  Offset fabPosition = Offset.zero;
  Offset containerPosition = Offset.zero;

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _getWidgetPositions();
  });
}

void _getWidgetPositions() {
  setState(() {
    drawerPosition = _getPositionFromKey(drawerKey);
    appBarPosition = _getPositionFromKey(appBarKey);
    bottomBarPosition = _getPositionFromKey(bottomBarKey);
    fabPosition = _getPositionFromKey(fabKey);
    containerPosition = _getPositionFromKey(containerKey);
  });
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
          print('Drawer: $drawerPosition');
          print('AppBar: $appBarPosition');
          print('BottomBar: $bottomBarPosition');
          print('FAB: $fabPosition');
          print('Container: $containerPosition');
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
            key: bottomBarKey,
            // bottom: 20,
            // left: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.clear),
            ),
          ),
        ],
      ),
    );
  }
}


      // Stack(
      //   children: [
      //     // Animated moving icon
      //     AnimatedPositioned(
      //       duration: Duration(seconds: 1),
      //       left: positions[_currentStep].dx,
      //       top: positions[_currentStep].dy,
      //       child: Icon(Icons.star, size: 40, color: Colors.blue),
      //     ),
      //     // The container with the target widget
      //     Positioned(
      //       left: 150,
      //       top: 400,
      //       child: Container(
      //         width: 100,
      //         height: 100,
      //         color: Colors.amber,
      //         child: Center(child: Icon(Icons.home, size: 40)),
      //       ),
      //     ),
      //   ],
      // ),