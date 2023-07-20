import 'package:flutter/material.dart';
import '../constants.dart';
import '../services.dart';
import 'SignScreen.dart';

class PersonalDataScreen extends StatelessWidget {
   PersonalDataScreen({Key? key}) : super(key: key);

  void _signOutGoogle(BuildContext context) async {
    FirebaseServices firebaseServices = FirebaseServices();
    await firebaseServices.googleSignOut();
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => SignScreen())); // Navigate back after signing out
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
                const Expanded( // Wrap the text with Expanded to take available space
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
                padding: EdgeInsets.only(
                  left: 15,
                  top: 20,
                  right: 15,
                ),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color:Colors.white
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1)
                                  )
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/user.png"
                                  ),
                                )
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
