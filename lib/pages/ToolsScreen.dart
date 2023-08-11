import 'package:flutter/material.dart';
import '../constants.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Tools",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: kPrimaryColorG1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              customDivider(),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      toolCard(
                        name: 'Voice to Text Summarization',
                        routeName: '/voiceToText',
                        context: context,
                      ),
                      const SizedBox(height: 30),
                      toolCard(
                        name: 'To Do List',
                        routeName: '/toDo',
                        context: context,
                      ),
                      const SizedBox(height: 30),
                      toolCard(
                        name: 'Task Reminder',
                        routeName: '/taskReminder',
                        context: context,
                      ),
                      const SizedBox(height: 30),
                      toolCard(
                        name: 'ADHD Test',
                        routeName: '/adhdTest',
                        context: context,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customDivider() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        thickness: 0.75,
        color: kPrimaryColorG1,
      ),
    );
  }

  Widget toolCard({
    required String name,
    required String routeName,
    required BuildContext context,
  }) {
    return Stack(
      children: [
        Container(
          width: 400,
          height: 100,
          decoration: BoxDecoration(
            color: kPrimaryColorG1.withOpacity(0.9),
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
