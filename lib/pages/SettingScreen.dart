import 'package:cogniezer_app/constants.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(12),
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 35,
            ),
            userProfile(),
            CustomDivider(),
          ],
        ),
      ),
    );
  }
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

Widget userProfile() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage:
            AssetImage("assets/images/ernest-flowers-P62INeB2yz4-unsplash.jpg"),
      ),
      title: Text(
        "Sampath Chathuranga",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: kPrimaryColorG1),
      ),
      subtitle: Text(
        "abcdef@gmail.com",
        style: TextStyle(fontSize: 16, color: kPrimaryColorG1),
      ),
    ),
  );
}
