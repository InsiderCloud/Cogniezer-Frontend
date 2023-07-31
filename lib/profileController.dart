import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController with ChangeNotifier {
  final picker = ImagePicker();

  File? _selectedImage;
  File? get image => _selectedImage;

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
                  leading: Icon(Icons.camera, color: Colors.black),
                  title: Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    pickImageFromGallery(context);
                  },
                  leading: Icon(Icons.image, color: Colors.black),
                  title: Text("Gallery"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
