import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
                Icons.arrow_back,
                color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Text("about Us",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}