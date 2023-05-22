import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cogniezer_app/constants.dart';



class IconsForSign extends StatelessWidget {
  final String src;
  final VoidCallback press;
  const IconsForSign({
    Key? key,
    required this.src,
    required this.press,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryColorG1,
            ),
            shape: BoxShape.circle
        ),
        child: SvgPicture.asset(
          src,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}