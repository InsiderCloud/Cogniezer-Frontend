import 'package:cogniezer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late User? _user;
  late String _userName = '';
  late String _userEmail = '';
  ImageProvider<Object>? _profilePic;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          _userName = snapshot.data()!['username'];
          _userEmail = snapshot.data()!['userEmail'];
          String? profilePicture = snapshot.data()!['userPhoto'];
          _profilePic = profilePicture != null ? NetworkImage(profilePicture) : null;
        });
      }
    }
  }

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
            SizedBox(
              height: 30,
            ),
            colorTiles(context),
          ],
        ),
      ),
    );
  }

  Widget userProfile() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: _profilePic != null
          ? _profilePic!
          :AssetImage("assets/images/user.png"),
          radius: 35,
        ),
        title: Text(
          _userName.isNotEmpty ? _userName : 'Loading...',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: kPrimaryColorG1),
        ),
        subtitle: Text(
          _userEmail.isNotEmpty ? _userEmail : 'Loading...',
          style: TextStyle(fontSize: 16, color: kPrimaryColorG1),
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

  Widget colorTiles(BuildContext context) {
    return Column(
      children: [
        colorTile(Icons.person_outline, kPrimaryColorG1, "Personal Data",
            '/personal_data', context),
        SizedBox(
          height: 30,
        ),
        colorTile(Icons.lock_outlined, kPrimaryColorG1, "Security", '/security',
            context),
        SizedBox(
          height: 30,
        ),
        colorTile(Icons.email_outlined, kPrimaryColorG1, "Contact Us",
            '/contact_us', context),
        SizedBox(
          height: 30,
        ),
        colorTile(Icons.star_border_outlined, kPrimaryColorG1, "Rate this App",
            '/rate_app', context),
        SizedBox(
          height: 30,
        ),
        colorTile(
            Icons.info_outline, kPrimaryColorG1, "About Us", '/about_us', context),
      ],
    );
  }

  Widget colorTile(IconData icon, Color color, String text, String routeName,
      BuildContext context) {
    return ListTile(
      leading: Container(
        child: Icon(icon, color: color),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: kPrimaryColorG2.withOpacity(0.2),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500, color: kPrimaryColorG1),
      ),
      trailing: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Icon(
          Icons.arrow_forward_ios,
          color: kPrimaryColorG1,
          size: 20,
        ),
      ),
    );
  }
}
