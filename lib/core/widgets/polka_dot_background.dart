import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PolkaDotBackground extends StatelessWidget {
  const PolkaDotBackground({
    required this.child,
    this.showBottomGradient = false,
    super.key,
  });

  final Widget child;
  final bool showBottomGradient;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: AppColors.beige),
        const CustomPaint(painter: _PolkaDotPainter()),
        if (showBottomGradient)
          const Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.34,
              widthFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x00315F9B), AppColors.navy],
                  ),
                ),
              ),
            ),
          ),
        child,
      ],
    );
  }
}

class _PolkaDotPainter extends CustomPainter {
  const _PolkaDotPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.blue.withValues(alpha: 0.28);
    const spacing = 34.0;
    for (double y = 16; y < size.height; y += spacing) {
      for (double x = 16; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), 2.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
