import 'package:cogniezer_app/pages/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'pages/SignScreen.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(
    builder: (context) => MyApp(), // Wrap your app
  ),);
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
      home: SignScreen(),
    );
  }
}

