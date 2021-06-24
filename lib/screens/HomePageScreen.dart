import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_app/variables.dart';

import '../screens/ProfileScreen.dart';
import 'package:video_app/screens/VideoConferenceScreen.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int page = 0;
  List pageOptions = [VideoConferenceScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      //bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: MyStyle(17, Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: MyStyle(17, Colors.black),
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Video Call",
            icon: Icon(Icons.video_call, size: 32),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person, size: 32),
          ),
          // BottomNavigationBarItem(
          //   title: Text("SignOut"),
          //   icon: Icon(Icons.logout, size: 32),
          // )
        ],
      ),
      body: pageOptions[page],
    );
  }
}
