import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cogniezer_app/components/HaveAnAccountCheck.dart';
import 'package:cogniezer_app/components/button.dart';
import '../components/FieldForInput.dart';
import 'HomeScreen.dart';
import 'SignScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  void _validateInputs() {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    final bool isEmailValid = email.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
    final bool isPasswordValid = password.length >= 6;

    setState(() {
      _isEmailValid = isEmailValid;
      _isPasswordValid = isPasswordValid;

      if (isEmailValid && isPasswordValid) {
        _saveUserToDatabase();
      }
    });
  }

  void _saveUserToDatabase(BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).onError((error, stackTrace) {
      print("Error ${error.toString()}");
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login_bg.jpg'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
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
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: <Widget>[
                        FieldForInput(
                          text: "Email",
                          decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey)),
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
                  SizedBox(
                    height: 30,
                  ),
                  MainElevatedButton(
                    onPressed: _validateInputs,
                    child: Text(
                      "Log In",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  HaveAnAccountCheck(
                      login: true,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignScreen()),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
