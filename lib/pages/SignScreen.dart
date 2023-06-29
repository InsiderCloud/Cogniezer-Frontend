import 'package:cogniezer_app/components/OrDivider.dart';
import 'package:cogniezer_app/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'LoginScreen.dart';
import '../components/FieldForInput.dart';
import '../components/HaveAnAccountCheck.dart';
import '../components/IconsForSign.dart';
import '../components/button.dart';

class SignScreen extends StatefulWidget {
  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseServices _firebaseServices = FirebaseServices();

  bool _isNameValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  void _validateInputs(BuildContext context) {
    setState(() {
      _isNameValid = _nameController.text.isNotEmpty;
      _isEmailValid = _emailController.text.isNotEmpty &&
          RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(_emailController.text);
      _isPasswordValid = _passwordController.text.length >= 6;

      if (_isNameValid && _isEmailValid && _isPasswordValid) {
        _saveUserToDatabase(context);
      }
    });
  }

  void _saveUserToDatabase(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        print("Sign Failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 330,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_bg.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "Sign",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, .2),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        FieldForInput(
                          text: "Name",
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          icon: Icon(Icons.person_rounded),
                          controller: _nameController,
                          isValid: _isNameValid,
                        ),
                        FieldForInput(
                          text: "Email",
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          icon: Icon(Icons.email),
                          controller: _emailController,
                          isValid: _isEmailValid,
                        ),
                        FieldForInput(
                          text: "Password",
                          icon: Icon(Icons.lock),
                          controller: _passwordController,
                          isValid: _isPasswordValid,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  MainElevatedButton(
                    onPressed: () => _validateInputs(context),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  HaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconsForSign(
                        src: "assets/icons/facebook.svg",
                        press: () async {
                          await FirebaseServices().signInWithFacebook();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HomeScreen()));
                        },
                      ),
                      IconsForSign(
                        src: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                      IconsForSign(
                        src: "assets/icons/google-plus.svg",
                        press: () async {
                          bool? result = await _firebaseServices.signInWithGoogle();
                          if(result !=null) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomeScreen()));
                          }

                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
