import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../constants.dart';
import '../services.dart';
import 'SignScreen.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  late User? _user;
  late String _userName = '';
  ImageProvider<Object>? _profilePic;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> getUserData() async {
    _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          _userName = snapshot.data()!['username'];
          String? profilePicture = snapshot.data()!['userPhoto'];
          _profilePic =
          profilePicture != null ? NetworkImage(profilePicture) : null;
        });
      }
    }
  }

  void _signOutGoogle(BuildContext context) {
    FirebaseServices firebaseServices = FirebaseServices();
    firebaseServices.googleSignOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignScreen(),
      ),
    ); // Navigate back after signing out
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
              bottom: 20.0,
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
                const Expanded(
                  // Wrap the text with Expanded to take available space
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                  onPressed: () {
                    _signOutGoogle(context);
                  },
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
              child: Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 20,
                  right: 15,
                ),
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // When the user taps the profile picture, show a dialog with the full-size image
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: _profilePic != null
                                  ? Image(image: _profilePic!, fit: BoxFit.contain)
                                  : Image.asset(
                                "assets/images/user.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(width: 4, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: _profilePic != null
                                    ? Image(image: _profilePic!, fit: BoxFit.cover)
                                    : Image.asset(
                                  "assets/images/user.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 4, color: Colors.white),
                                  color: kPrimaryColorG1,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    _pickImage();
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    buildTextField(
                      "Name",
                      _userName.isNotEmpty ? _userName : 'Set Name',
                    ),
                    buildTextField("Location", "Colombo"),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColorG1,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
