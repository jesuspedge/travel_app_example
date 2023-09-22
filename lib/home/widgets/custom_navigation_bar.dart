import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends CustomPainter {
  final Color color;

  CustomBottomNavigationBar({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final width25 = width * 0.25;
    final width5 = width * 0.5;
    final width75 = width * 0.75;
    final height75 = height * 0.75;

    final path = Path()
      ..lineTo(width25, 0)
      ..cubicTo((width25 + 50), 0, (width5 - 50), height75, width5, height75)
      ..cubicTo((width5 + 50), height75, (width75 - 50), 0, width75, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, 0);

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(CustomBottomNavigationBar oldDelegate) => false;
}
