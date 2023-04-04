import 'dart:math' as math;
import 'package:flutter/material.dart';

class CirclesAnimation extends StatefulWidget {
  final double bigRadius;
  final double circleRadius;
  final Color color;
  final Duration duration;
  final double startAngle; // Adicionado o parametro startAngle
  const CirclesAnimation({
    super.key,
    this.bigRadius = 100,
    this.circleRadius = 12,
    required this.color,
    this.duration = const Duration(seconds: 5),
    this.startAngle = 0, // Definido o valor padrão para startAngle
  });

  @override
  State<CirclesAnimation> createState() => _CirclesAnimationState();
}

class _CirclesAnimationState extends State<CirclesAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final ValueNotifier<double> _angle = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    _animationController.addListener(() {
      _angle.value =
          widget.startAngle + _animationController.value * 2 * math.pi;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _angle,
      builder: (_, value, __) {
        return CustomPaint(
          painter: CirclesPainter(
            value,
            widget.bigRadius,
            widget.circleRadius,
            widget.color,
          ),
          size: const Size(200, 200),
        );
      },
    );
  }
}

class CirclesPainter extends CustomPainter {
  final double angle;
  final double bigRadius;
  final double circleRadius;
  final Color color;

  CirclesPainter(this.angle, this.bigRadius, this.circleRadius, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint smallCirclePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double smallRadius = circleRadius;

    final center = Offset(size.width / 2, size.height / 2);
    final smallCenter = Offset(
      center.dx + bigRadius * math.cos(angle),
      center.dy + bigRadius * math.sin(angle),
    );

    canvas.drawCircle(smallCenter, smallRadius, smallCirclePaint);
  }

  @override
  bool shouldRepaint(CirclesPainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}
