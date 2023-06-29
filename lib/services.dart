import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool?> signInWithGoogle() async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if(user != null){
        if(userCredential.additionalUserInfo!.isNewUser){
          await _firestore.collection('users').doc(user.uid).set({
            'username' : user.displayName,
            'userid' : user.uid,
            'userEmail' : user.email,
            'userPhoto' : user.photoURL,
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
    try{
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (error) {
      print('Sign Out Error: $error');
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
            accessToken.token);

        // Sign in with the credential
        final UserCredential userCredential = await _auth.signInWithCredential(
            credential);
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