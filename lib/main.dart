import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'constants.dart';
import 'pages/SignScreen.dart';


void main() {
  runApp(DevicePreview(
    builder: (context) => MyApp(), // Wrap your app
  ),);
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cogniezer',
      theme: ThemeData(
        primaryColor: kPrimaryColorG1,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SignScreen(),
    );
  }
}

