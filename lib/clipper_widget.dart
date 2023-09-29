import 'package:flutter/material.dart';

class ClipperWidget extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(12, 0);
    path.lineTo(14.5, 14);
    path.lineTo(0, 44);

    path.lineTo(0, size.height - 20);
    path.lineTo(20, size.height);

    path.lineTo(size.width - 20, size.height);
    path.lineTo(size.width, size.height - 20);

    path.lineTo(size.width, 44);
    path.lineTo(size.width - 15, 14);
    path.lineTo(size.width - 13, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
