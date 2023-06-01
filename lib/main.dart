import 'package:cogniezer_app/pages/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'constants.dart';
import 'pages/SignScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: SplashScreen(),
    );
  }
}

