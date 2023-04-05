import 'package:flutter/material.dart';

import 'circle_animation_widget.dart';

class CircleProductWidget extends StatelessWidget {
  final double radius;
  final List<Color> colors;

  const CircleProductWidget({
    super.key,
    required this.radius,
    required this.colors,
  }) : assert(colors.length == 3);

  @override
  Widget build(BuildContext context) {
    double outerCircleRadius = radius;
    double middleCircleRadius = radius * 0.7;
    double innerCircleRadius = radius * 0.48;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: outerCircleRadius * 2,
          width: outerCircleRadius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.first.withOpacity(0.4),
          ),
        ),
        Container(
          height: middleCircleRadius * 2,
          width: middleCircleRadius * 2,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: colors[1].withOpacity(0.4)),
        ),
        Container(
          height: innerCircleRadius * 2,
          width: innerCircleRadius * 2,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: colors.last.withOpacity(0.4)),
        ),
        CirclesAnimation(
          bigRadius: radius * 0.60,
          circleRadius: 8,
          color: colors.last,
          duration: const Duration(seconds: 10),
        ),
        CirclesAnimation(
          bigRadius: radius * 0.84,
          circleRadius: 8,
          startAngle: 1,
          color: colors.first,
          duration: const Duration(seconds: 12),
        ),
      ],
    );
  }
}
