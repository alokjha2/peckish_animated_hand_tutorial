// import 'package:flutter/material.dart';

// class HighlightOverlay extends StatelessWidget {
//   final GlobalKey targetKey;

//   const HighlightOverlay({Key? key, required this.targetKey}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     RenderBox? targetBox = targetKey.currentContext?.findRenderObject() as RenderBox?;
//     if (targetBox == null) return SizedBox.shrink();

//     Offset position = targetBox.localToGlobal(Offset.zero);
//     Size size = targetBox.size;

//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: () {}, // Block interactions
//           child: Container(
//             color: Colors.black.withOpacity(0.7),
//           ),
//         ),
//         Positioned(
//           top: position.dy,
//           left: position.dx,
//           child: Container(
//             width: size.width,
//             height: size.height,
//             decoration: const BoxDecoration(
//               color: Colors.transparent,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
