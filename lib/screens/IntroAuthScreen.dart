import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:video_app/authentication/AuthPageScreen.dart';
import 'package:video_app/variables.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: "Welcome",
            body: "Get your video call started,Smooth and Good",
            image: Center(
              child: Image.asset(
                'images/welcome.png',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
                bodyTextStyle: MyStyle(20, Colors.black45),
                titleTextStyle: MyStyle(20, Colors.black))),
        PageViewModel(
            title: "Journey Beigins",
            body: "Stay Connected, Keep in Touch",
            image: Center(
              child: Image.asset(
                'images/conference.png',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
                bodyTextStyle: MyStyle(20, Colors.black45),
                titleTextStyle: MyStyle(20, Colors.black))),
        PageViewModel(
            title: "Security",
            body: "Stay secured and stay connected",
            image: Center(
              child: Image.asset(
                'images/secure.jpg',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
                bodyTextStyle: MyStyle(20, Colors.black45),
                titleTextStyle: MyStyle(20, Colors.black))),
      ],
      onDone: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthPageScreen()));
        print("DONE");
      },
      onSkip: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthPageScreen()));
        print("SKIP");
      },
      showSkipButton: true,
      skip: const Icon(
        Icons.skip_next,
        size: 45,
      ),
      next: const Icon(Icons.arrow_forward_ios),
      done: Text(
        "DONE",
        style: MyStyle(20, Colors.black),
      ),
    );
  }
}
