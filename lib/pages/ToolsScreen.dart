import 'package:flutter/material.dart';

import '../constants.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Tools",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: kPrimaryColorG1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomDivider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 0.75,
        color: kPrimaryColorG1,
      ),
    );
  }
}
