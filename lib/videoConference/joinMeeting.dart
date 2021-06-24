import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:video_app/variables.dart';

class JoinMeetingScreen extends StatefulWidget {
  @override
  _JoinMeetingScreenState createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  bool isVideoMuted = true;
  bool isAudioMuted = true;
  String username = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userDoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userDoc.data()['username'];
    });
  }

  joinMeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featurefalgs = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      if (Platform.isAndroid) {
        featurefalgs[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featurefalgs[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions()
            ..room = roomController.text
            ..userDisplayName =
                nameController.text == '' ? username : nameController.text
            ..audioMuted = isAudioMuted
            ..videoMuted = isVideoMuted
          //..featureFlags.addAll(featurefalgs)
          ;

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              "Room Code",
              style: MyStyle(20),
            ),
            SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              controller: roomController,
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              obscureText: false,
              autoDisposeControllers: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
              animationDuration: Duration(milliseconds: 300),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              style: MyStyle(20),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelStyle: MyStyle(15),
                  labelText: "Name(Leave if you want your username"),
            ),
            SizedBox(
              height: 10,
            ),
            CheckboxListTile(
                value: isVideoMuted,
                onChanged: (value) {
                  setState(() {
                    isVideoMuted = value;
                  });
                },
                title: Text(
                  "Video Muted",
                  style: MyStyle(
                    18,
                    Colors.black,
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            CheckboxListTile(
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
                title: Text(
                  "Audio Muted",
                  style: MyStyle(
                    18,
                    Colors.black,
                  ),
                )),
            Divider(
              height: 48,
              thickness: 2.0,
            ),
            Text(
              "You can change the settings dutring a meeting",
              style: MyStyle(13),
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 48,
              thickness: 2.0,
            ),
            InkWell(
              onTap: () {
                joinMeeting();
              },
              child: Container(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger)),
                child: Center(
                  child: Text(
                    "Join Meeting",
                    style: MyStyle(20, Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
