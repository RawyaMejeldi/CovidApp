import 'package:flutter/cupertino.dart';

class LightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.7);
    Offset curvePoint1 = Offset(size.width * 0.25, size.height * 0.45);
    Offset curvePoint2 = Offset(size.width * 0.75, size.height * 0.5);
    path.quadraticBezierTo(
        curvePoint1.dx, curvePoint1.dy, curvePoint2.dx, curvePoint2.dy);
    Offset curvePoint3 = Offset(size.width * 0.95, size.height * 0.5);
    Offset endPoint = Offset(size.width, size.height * 0.3);
    path.quadraticBezierTo(
        curvePoint3.dx, curvePoint3.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class DarkClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.6);
    Offset curvePoint1 = Offset(size.width * 0.4, size.height * 0.7);
    Offset curvePoint2 = Offset(size.width * 0.55, size.height * 0.55);
    path.quadraticBezierTo(
        curvePoint1.dx, curvePoint1.dy, curvePoint2.dx, curvePoint2.dy);
    Offset curvePoint3 = Offset(size.width * 0.67, size.height * 0.45);
    Offset endPoint = Offset(size.width, size.height * 0.5);
    path.quadraticBezierTo(
        curvePoint3.dx, curvePoint3.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
