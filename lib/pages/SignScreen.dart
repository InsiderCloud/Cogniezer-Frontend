import 'package:flutter/material.dart';

import 'package:cogniezer_app/components/HaveAnAccountCheck.dart';
import 'package:cogniezer_app/components/IconsForSign.dart';
import 'package:cogniezer_app/components/button.dart';
import '../components/FieldForInput.dart';
import '../components/OrDivider.dart';
import 'LoginScreen.dart';


class SignScreen extends StatelessWidget {

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
                      fit: BoxFit.fill
                  )
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
                              fontWeight: FontWeight.bold),),
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
                              offset: Offset(0,10)
                          )
                        ]
                    ),
                    child: Column(
                      children: <Widget>[
                        FieldForInput(
                          text: "Name",
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                        ),
                        FieldForInput(
                          text: "Email",
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                        ),
                        FieldForInput(
                          text: "Password",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                   MainElevatedButton(
                      onPressed: () {

                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10,),
                    HaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        }),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconsForSign(
                        src: "assets/icons/facebook.svg",
                        press: () {},

                      ),
                      IconsForSign(
                        src: "assets/icons/twitter.svg",
                        press: () {},

                      ),
                      IconsForSign(
                        src: "assets/icons/google-plus.svg",
                        press: () {},
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

