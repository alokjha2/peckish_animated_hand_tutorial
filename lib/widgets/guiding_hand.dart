import 'package:flutter/material.dart';

class GuidingHand extends StatelessWidget {
  final Offset position;
  final VoidCallback onTap;

  const GuidingHand({
    Key? key,
    required this.position,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position.dy,
      left: position.dx,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(Icons.hail_rounded, color: Colors.black,)
        // Image.asset(
        //   'assets/animated_hand.png', // Add the hand.png image
        //   width: 50,
        //   height: 50,
        // ),
      ),
    );
  }
}
