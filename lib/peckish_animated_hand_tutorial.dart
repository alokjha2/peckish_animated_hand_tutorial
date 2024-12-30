import 'package:flutter/material.dart';
import 'package:peckish_animated_hand_tutorial/widgets/guiding_hand.dart';
import 'package:peckish_animated_hand_tutorial/widgets/highlight_overlay.dart';

class ShowcaseWidget extends StatefulWidget {
  final List<ShowcaseStep> steps;  // List of steps to showcase
  final VoidCallback onComplete;  // Callback when all steps are completed

  const ShowcaseWidget({
    Key? key,
    required this.steps,
    required this.onComplete,
  }) : super(key: key);

  @override
  _ShowcaseWidgetState createState() => _ShowcaseWidgetState();
}

class _ShowcaseWidgetState extends State<ShowcaseWidget> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < widget.steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      widget.onComplete();  // Complete the tutorial after the last step
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentStep >= widget.steps.length) {
      return SizedBox.shrink(); // Hide when completed
    }

    final step = widget.steps[_currentStep];

    return Stack(
      children: [
        HighlightOverlay(targetKey: step.key),  // Highlight the target widget
        GuidingHand(
          position: step.handPosition,
          onTap: _nextStep,  // Move to the next step when tapped
        ),
        Positioned(
          top: step.descriptionPosition.dy,
          left: step.descriptionPosition.dx,
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.black.withOpacity(0.8),
            child: Text(
              step.description,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}


class ShowcaseStep {
  final GlobalKey key;
  final Offset handPosition;
  final Offset descriptionPosition;
  final String description;

  ShowcaseStep({
    required this.key,
    required this.handPosition,
    required this.descriptionPosition,
    required this.description,
  });
}
