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
              SizedBox(
                height: 30,
              ),
              ToolCard(
                name: 'Voice to Text Summarization', routeName: '/voiceToText', context: context,
              ),
              SizedBox(
                height: 30,
              ),
              ToolCard(
                name: 'To Do List', routeName: '/toDo', context: context,
              ),
              SizedBox(
                height: 30,
              ),
              ToolCard(
                name: 'Task Reminder', routeName: '/taskReminder', context: context ,
              ),
              SizedBox(
                height: 30,
              ),
              ToolCard(
                name: 'ADHD Test', routeName: '/adhdTest', context: context,
              ),

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

  Widget ToolCard
      ({
        required String name,
        required String routeName,
        required BuildContext context
      })
  {
    return Stack(
      children: [
        Container(
          width: 400,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: kPrimaryColorG1,
              width: 2,
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kPrimaryColorG1,
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 10,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, routeName);
            },
            child: Icon(
              Icons.arrow_forward,
              color: kPrimaryColorG1,
            ),
          ),
        ),
      ],
    );
  }
}
