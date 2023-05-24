import 'package:flutter/material.dart';

class FieldForInput extends StatefulWidget {
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
  State<FieldForInput> createState() => _FieldForInputState();
}

class _FieldForInputState extends State<FieldForInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: widget.decoration,
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.text,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: widget.icon,
        ),
      ),
    );
  }
}

