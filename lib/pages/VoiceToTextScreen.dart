import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'dart:convert';

import '../constants.dart';

class VoiceToTextScreen extends StatefulWidget {
  const VoiceToTextScreen({Key? key}) : super(key: key);

  @override
  _VoiceToTextScreenState createState() => _VoiceToTextScreenState();
}

class _VoiceToTextScreenState extends State<VoiceToTextScreen> {
  bool isListening = false;
  final stt.SpeechToText _speech = stt.SpeechToText();
  final TextEditingController _userInputController = TextEditingController();
  final TextEditingController _summarizationController =
      TextEditingController();

  Future<String> _summarizeText(String inputText) async {
    final url = "http://20.197.17.170:8000/api/predict";

    final response = await http.post(
      Uri.parse(url),
      body: json.encode({"text": inputText}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final summary = responseData['summary'];
      return summary;
    } else {
      throw Exception('Failed to load summary');
    }
  }

  Future<void> _initializeSpeechRecognizer() async {
    if (await _speech.initialize()) {
      print("Speech recognition is available");
    } else {
      print("Speech recognition is not available");
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeSpeechRecognizer();
  }

  @override
  void dispose() {
    _userInputController.dispose();
    _summarizationController.dispose();
    _speech.stop();
    super.dispose();
  }

  Future<void> _toggleListening() async {
    if (!isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _userInputController.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() {
        isListening = false;
      });
      _speech.stop();
      await _getAndSetSummary(_userInputController.text);
    }
  }

  Future<void> _getAndSetSummary(String inputText) async {
    try {
      final summary = await _summarizeText(inputText);
      setState(() {
        _summarizationController.text = summary;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

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
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    // User input text field
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kPrimaryColorG1,
                        ),
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        controller: _userInputController,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          hintText: "Press the button to speak or type here...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Floating Action Button
                    AvatarGlow(
                      animate: isListening,
                      repeat: true,
                      endRadius: 80,
                      glowColor: kPrimaryColorG2,
                      duration: Duration(milliseconds: 1000),
                      child: FloatingActionButton(
                        onPressed: _toggleListening,
                        child: Icon(isListening ? Icons.mic : Icons.mic_none),
                        backgroundColor: kPrimaryColorG1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Summarization text field
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kPrimaryColorG1,
                        ),
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        controller: _summarizationController,
                        maxLines: 8,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: "Summarization will appear here...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
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
