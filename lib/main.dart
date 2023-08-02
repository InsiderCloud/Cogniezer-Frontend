import 'package:cogniezer_app/pages/ADHDTestScreen.dart';
import 'package:cogniezer_app/pages/AboutUsScreen.dart';
import 'package:cogniezer_app/pages/ContactUsScreen.dart';
import 'package:cogniezer_app/pages/PersonalDataScreen.dart';
import 'package:cogniezer_app/pages/RateAppScreen.dart';
import 'package:cogniezer_app/pages/SecurityScreen.dart';
import 'package:cogniezer_app/pages/SplashScreen.dart';
import 'package:cogniezer_app/pages/TaskReminderScreen.dart';
import 'package:cogniezer_app/pages/ToDoScreen.dart';
import 'package:cogniezer_app/pages/VoiceToTextScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    builder: (context) => const MyApp(), // Wrap your app
  ),);
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cogniezer',
      theme: ThemeData(
        primaryColor: kPrimaryColorG1,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/voiceToText': (context) => const VoiceToTextScreen(),
        '/toDo': (context) => ToDoScreen(),
        '/taskReminder': (context) => const TaskReminderScreen(),
        '/adhdTest': (context) => const ADHDTestScreen(),
        '/personal_data': (context) => const PersonalDataScreen(),
        '/security': (context) => const SecurityScreen(),
        '/contact_us': (context) => const ContactUsScreen(),
        '/rate_app': (context) => const RateAppScreen(),
        '/about_us': (context) => const AboutUsScreen(),
      },
      home: SplashScreen(),
    );
  }
}

