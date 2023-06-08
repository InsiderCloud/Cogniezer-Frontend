import 'package:flutter/cupertino.dart';

import '../constants.dart';

class EmojiFace extends StatelessWidget {
  final String emojiFace;

  const EmojiFace({
    Key? key,
    required this.emojiFace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColorG2,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Center(
        child: Text(
          emojiFace,
          style: TextStyle(
            fontSize: 20,

          ),
        ),
      )
    );
  }
}
