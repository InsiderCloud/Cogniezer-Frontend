import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                      fit: BoxFit.fill
                  )
                ),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                      ),
                    ),
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