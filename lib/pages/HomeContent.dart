import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cogniezer_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/EmojiFace.dart';

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late User? _user;

  late String _userName = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          String fullName = snapshot.data()!['username'];
          List<String> nameParts = fullName.split(' ');
          _userName = nameParts[0];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: Container(
              color: kPrimaryColorG1,
              height: 320,
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
                            "Hi, $_userName!",
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
                                color: HomeScreenBtnBgColor,
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
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "How do you feel today?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      //Emojies
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              EmojiFace(
                                emojiFace: '😊',
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Fine",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              EmojiFace(
                                emojiFace: '😃',
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Excellent",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              EmojiFace(
                                emojiFace: '😔',
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Sad",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              EmojiFace(
                                emojiFace: '😠',
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Angry",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                  "Activities for Relaxation",
                style: TextStyle(
                  color: kPrimaryColorG1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            indent: 30.0,
            endIndent: 30.0,
            color: kPrimaryColorG1,
          ),
          Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    InkWell(
                      child: activityCard(
                          name: 'Music',
                          context: context,
                          img: 'assets/images/music.jpg'),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: activityCard(
                          name: 'Meditation',
                          context: context,
                          img: 'assets/images/meditation.jpg'),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: activityCard(
                          name: 'Breath Exercises',
                          context: context,
                          img: 'assets/images/breath exer.jpg'),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: activityCard(
                          name: 'Yoga',
                          context: context,
                          img: 'assets/images/yoga.jpeg'),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
          )

        ],
      ),
    );
  }

  Widget activityCard({
    required String name,
    required BuildContext context,
    required String img,
  }) {
    return Stack(
      children: [
        Container(
          width: 380,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: kPrimaryColorG1,
              width: 2,
            ),
          ),
        ),

        Positioned(
          top: 50,
          left: 10,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kPrimaryColorG1,
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 10,
          child: Image.asset(
            img,
            width: 120,
            height: 120,
          ),
        ),
      ],
    );
  }

}
