import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  final double height;
  final double width;
  const SquareTile({
    super.key,
    required this.imagePath, required this.onTap, required this.height, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(4),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}