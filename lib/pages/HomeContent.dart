import 'package:cogniezer_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/EmojiFace.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: kPrimaryColorG1,
        height: 350,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Hi User
                    Text(
                      "Hi, Name!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Notification
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColorG2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.notifications,
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
    );
  }
}
