import 'package:cogniezer_app/pages/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Cogniezer',
      theme: ThemeData(
        primaryColor: kPrimaryColorG1,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}

