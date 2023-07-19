import 'package:flutter/material.dart';

import '../constants.dart';

class VoiceToTextScreen extends StatefulWidget {
  const VoiceToTextScreen({Key? key}) : super(key: key);

  @override
  _VoiceToTextScreenState createState() => _VoiceToTextScreenState();
}

class _VoiceToTextScreenState extends State<VoiceToTextScreen> {
  TextEditingController _userInputController = TextEditingController();
  TextEditingController _summarizationController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColorG1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 30.0,
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    // Handle back arrow button press here
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10.0),
                const Text(
                  'V2T Summarization',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    // User input text field
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextField(
                        controller: _userInputController,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: "Speak or type here...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Floating Action Button
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.mic),

                    ),
                    const SizedBox(height: 20),
                    // Summarization text field
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextField(
                        controller: _summarizationController,
                        maxLines: 10,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: "Summarization will appear here...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}