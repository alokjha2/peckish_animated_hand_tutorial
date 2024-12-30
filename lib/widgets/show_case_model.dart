import 'package:flutter/widgets.dart';

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
