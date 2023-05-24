import 'package:flutter/material.dart';

class FieldForInput extends StatelessWidget {
  final String text;
  final BoxDecoration? decoration;
  final Widget icon;
  const FieldForInput({
    Key? key,
    required this.text,
    this.decoration,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: decoration,
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: icon,
        ),
      ),
    );
  }
}

