import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<bool?> signInWithGoogle() async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'userid': user.uid,
            'userEmail': user.email,
            'userPhoto': user.photoURL,
          });
        }
        result = true;
      }
      return result;
    } catch (e) {
      print('Google Sign-In error: $e');
      return null;
    }
  }

  Future<void> googleSignOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (error) {
      print('Sign Out Error: $error');
    }
  }

  Future<String?> uploadImageToStorage(File imageFile) async {
    try {
      String uid = _auth.currentUser!.uid;
      String fileName = 'user_profile_$uid.jpg';
      Reference reference = _storage.ref().child('user_profiles').child(fileName);

      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Future<String?> uploadImageToStorage(File imageFile) async {
  //   try {
  //     // Generate a unique image name based on the current timestamp
  //     String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
  //
  //     // Reference to the Firebase Storage bucket
  //     Reference storageReference = FirebaseStorage.instance.ref().child('profile_images').child(fileName);
  //
  //     // Upload the image to Firebase Storage
  //     TaskSnapshot uploadTask = await storageReference.putFile(imageFile);
  //
  //     // Get the download URL of the uploaded image
  //     String downloadURL = await uploadTask.ref.getDownloadURL();
  //     return downloadURL;
  //   } catch (error) {
  //     print('Error uploading image to storage: $error');
  //     return null;
  //   }
  // }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    } catch (error) {
      print('Error getting user data: $error');
      return null;
    }
  }

  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);
    } catch (error) {
      print('Error updating user data: $error');
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Log in with Facebook
      final LoginResult result = await FacebookAuth.instance.login();

      // Check the login result
      if (result.status == LoginStatus.success) {
        // Get the access token
        final AccessToken accessToken = result.accessToken!;

        // Create the Facebook auth credential
        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.token,
        );

        // Sign in with the credential
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential;
      } else if (result.status == LoginStatus.cancelled) {
        print('Facebook Sign-In cancelled');
        return null;
      } else {
        print('Facebook Sign-In failed');
        return null;
      }
    } catch (error) {
      print('Facebook Sign-In error: $error');
      return null;
    }
  }

  Future<void> facebookSignOut() async {
    try {
      await _auth.signOut();
      await FacebookAuth.instance.logOut();
    } catch (error) {
      print('Sign Out Error: $error');
    }
  }
}
