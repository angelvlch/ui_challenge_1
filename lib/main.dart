import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.all(20),
          child: CustomPaint(
            painter: DemoPainter(),
            //  child: Text('sdsd'),
            foregroundPainter: DemoPainter(),
          ),
        ),
      ),
    );
  }
}

class DemoPainter extends CustomPainter {
  static const _groundHeight = 200.0;
  @override
  void paint(Canvas canvas, Size size) {
    final point1 = Offset(0, size.height / 2);
    final point2 = Offset(size.width, size.height / 2);
    final controlPoint =
        Offset((point2.dx - point1.dx) / 2, (size.height / 2) - 70);
    final point3 = Offset(size.width, size.height / 2 + 60);
    final point4 = Offset(0, size.height / 2 + 60);
    Path linePath = Path();
    linePath.moveTo(point1.dx, point1.dy);
    linePath.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, point2.dx, point2.dy);

    //linePath.close();
    final glowAreaPath = Path.from(linePath);
    glowAreaPath.lineTo(point3.dx, point3.dy);
    glowAreaPath.lineTo(point4.dx, point4.dy);
    glowAreaPath.close();
    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(linePath, linePaint);
    final glowPaint = Paint()
      ..shader = ui.Gradient.linear(
        controlPoint,
        Offset(size.width / 2, point4.dy),
        [
          Colors.blueAccent.withOpacity(0.4),
          Colors.blueAccent.withOpacity(0),
        ],
      );
    canvas.drawPath(linePath, linePaint);
    canvas.drawPath(glowAreaPath, glowPaint);
    //canvas.drawPath(glowAreaPath, linePaint);
  }

  void _drawHouse(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple;
    canvas.drawRect(
        Rect.fromPoints(
            Offset(size.width / 2 - size.width / 4,
                size.height - _groundHeight + 20),
            Offset(size.width / 2 + size.width / 4, 350)),
        paint);
  }

  void _drawGround(Size size, Canvas canvas) {
    final paint = Paint()
      ..color = Colors.green.shade600
      ..strokeWidth = _groundHeight;
    final dy = size.height - _groundHeight / 2;
    final startPoint = Offset(0, dy);
    final endPoint = Offset(size.width, dy);
    canvas.drawLine(startPoint, endPoint, paint);
  }

  void _drawSky(Canvas canvas) {
    canvas.drawPaint(Paint()..color = Colors.blue.withOpacity(0.3));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
