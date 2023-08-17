import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ProfileController with ChangeNotifier {

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  File? _selectedImage;
  File? get image => _selectedImage;

  bool _loading = false;
  bool get loading => _loading;

  Future pickImageFromGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future pickImageFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickImageFromCamera(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera, color: Colors.black),
                  title: const Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    pickImageFromGallery(context);
                  },
                  leading: const Icon(Icons.image, color: Colors.black),
                  title: const Text("Gallery"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> uploadImage() async {
    if (_selectedImage == null) {
      // No image selected, return null or handle the error accordingly.
      return null;
    }

    try {
      // Generate a unique filename for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a reference to the Firebase Storage location where you want to store the image
      firebase_storage.Reference storageReference =
      storage.ref().child('images/$fileName');

      // Upload the image to Firebase Storage
      await storageReference.putFile(_selectedImage!);

      // Get the download URL of the uploaded image
      String imageUrl = await storageReference.getDownloadURL();

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Handle the case when the user is not authenticated or signed in
        return null;
      }
      String userId = user.uid;

      // Update the 'userPhoto' field in Firestore with the download URL
      await ref.child(userId).child('profile_image').set(imageUrl);

      // Clear the selectedImage and reload the user data to update the profile picture
      _selectedImage = null;
      notifyListeners();

      // Return the download URL to be used in the UI or further processing
      return imageUrl;
    } catch (error) {
      // Handle any errors that occurred during the upload process
      if (kDebugMode) {
        print('Error uploading image: $error');
      }
      return null;
    }
  }

  // void uploadImage(BuildContext context) async {
  //
  //   setLoading(true);
  //   firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/profileImage' + SessionController().userId.toString());
  //
  //   firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);
  //
  //   await Future.value(uploadTask);
  //   final newUrl = await storageRef.getDownloadURL();
  //
  //   ref.child(SessionController().userId.toString()).update({
  //     'userPhoto': newUrl.toString()
  //   }).then((value) {
  //     Utils.toasstMessage('Profile Updated');
  //     setLoading(false);
  //     _selectedImage = null;
  //   }).onError((error, stackTrace) {
  //     setLoading(false);
  //     Utils.toasstMessage(error.toString());
  //
  //   });
  // }

}
