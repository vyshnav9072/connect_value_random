import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'LandingPage.dart';
import 'login_page.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Landing_Page(
                  title: 'landingpage',
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/svg/logoo.svg',
          // Replace with the path to your SVG file
          width: 150, // Set the desired width
          height: 150, // Set the desired height
        ),
      ),
    );
  }
}
