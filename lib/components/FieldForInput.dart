import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class FieldForInput extends StatelessWidget {
  final String text;
  final BoxDecoration? decoration;
  final Widget prefixicon;
  final TextEditingController controller;
  final bool isValid;
  final bool isPassword;

  const FieldForInput({
    Key? key,
    required this.text,
    this.decoration,
    required this.prefixicon,
    required this.controller,
    required this.isValid,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: decoration,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: prefixicon,
                  errorText: isValid ? null : 'Invalid $text',
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class FieldForInputWithSuffixIcon extends StatefulWidget {
  final String text;
  final BoxDecoration? decoration;
  final Widget prefixicon;
  final Widget suffixicon;
  final TextEditingController controller;
  final bool isValid;
  final bool isPassword;
  final VoidCallback? onSuffixPressed;

  const FieldForInputWithSuffixIcon({
    Key? key,
    required this.text,
    this.decoration,
    required this.prefixicon,
    required this.suffixicon,
    required this.controller,
    required this.isValid,
    this.isPassword = false,
    this.onSuffixPressed,
  }) : super(key: key);

  @override
  State<FieldForInputWithSuffixIcon> createState() => _FieldForInputWithSuffixIconState();
}

class _FieldForInputWithSuffixIconState extends State<FieldForInputWithSuffixIcon> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility(){
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: widget.decoration,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.text,
                hintStyle: TextStyle(color: Colors.grey[400]),
                errorText: widget.isValid ? null : 'Invalid ${widget.text}',
                prefixIcon: widget.prefixicon,
                suffixIcon: InkWell(
                  onTap: _togglePasswordVisibility,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _isPasswordVisible
                          ? Icon(Ionicons.eye_off)
                          : Icon(Ionicons.eye),
                  ),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
