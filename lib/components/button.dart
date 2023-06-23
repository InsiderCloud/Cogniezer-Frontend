import 'package:flutter/material.dart';

import 'package:cogniezer_app/constants.dart';

class MainElevatedButton extends StatelessWidget {
  final double height;
  final VoidCallback onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Gradient gradient;
  final Widget child;

  const MainElevatedButton({
    Key? key,
    required this.onPressed,
    this.borderRadius,
    this.height = 50.0,
    required this.child,
    this.gradient =
        const LinearGradient(colors: [kPrimaryColorG1, kPrimaryColorG2]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(10);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
