import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../profileController.dart';
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

  // Create TextEditingController for each text field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // Future<void> _pickImage() async {
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       _selectedImage = File(pickedImage.path);
  //     });
  //   }
  // }

  Future<void> getUserData() async {
    _user = FirebaseServices().getCurrentUser();

    if (_user != null) {
      Map<String, dynamic>? userData = await FirebaseServices().getUserData(_user!.uid);

      if (userData != null) {
        setState(() {
          _userName = userData['username'] ?? '';
          String? profilePicture = userData['userPhoto'];
          _profilePic = profilePicture != null ? NetworkImage(profilePicture) : null;
        });
      }
    }
  }

  void _signOutGoogle(BuildContext context) {
    FirebaseServices firebaseServices = FirebaseServices();
    firebaseServices.googleSignOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignScreen()),
    ); // Navigate back after signing out
  }

  // Future<void> _saveData() async {
  //   // First, check if the user has selected a new image
  //   if (_selectedImage != null) {
  //     // Upload the selected image to Firebase Storage
  //     String? downloadURL = await FirebaseServices().uploadImageToStorage(_selectedImage!);
  //
  //     if (downloadURL != null) {
  //       // If the image upload is successful, update the 'userPhoto' field in Firestore
  //       await FirebaseServices().updateUserData(_user!.uid, {'userPhoto': downloadURL});
  //
  //       // Clear the selectedImage and reload the user data to update the profile picture
  //       setState(() {
  //         _selectedImage = null;
  //         _profilePic = NetworkImage(downloadURL);
  //       });
  //     }
  //   }
  //
  //   // Then, update the 'username' field in Firestore with the new value from the text field
  //   String newName = _nameController.text.trim();
  //   if (newName.isNotEmpty) {
  //     await FirebaseServices().updateUserData(_user!.uid, {'username': newName});
  //     setState(() {
  //       _userName = newName;
  //     });
  //   }
  //
  //   // You can also update other fields (e.g., 'location') similarly if needed
  //
  //   // Show a snackbar to indicate that data has been saved
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Data saved successfully!')),
  //   );
  // }

  void clearTextFields() {
    _nameController.clear();
    _locationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColorG1,
      body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child: Consumer<ProfileController>(
              builder: (context, provider, child) {
                return Column(
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
                                          child: provider.image != null
                                              ? Image.file(provider.image!, fit: BoxFit.cover)
                                              : (_profilePic != null
                                              ? Image(image: _profilePic!, fit: BoxFit.cover)
                                              : Image.asset(
                                            "assets/images/user.png",
                                            fit: BoxFit.contain,
                                          )),
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
                                              provider.pickImage(context);
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
                                controller: _nameController,
                              ),
                              buildTextField("Location", "Colombo", controller: _locationController),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      clearTextFields();
                                    },
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
                                    onPressed: () {
                                      // _saveData(); // Navigate back after saving
                                    },
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
                );

              }
          ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, {required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: controller,
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
