import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';


import '../navigation/bottomnavigation_screen.dart';
import 'login_page.dart';

class Landing_Page extends StatefulWidget {
  const Landing_Page({Key? key, required this.title}) : super(key: key);
  //Named Route Id
  static String id = "Landing";
  final String title;
  @override
  _Landing_PageState createState() => _Landing_PageState();
}

class _Landing_PageState extends State<Landing_Page> {
  String? userToken;

  _checkAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = (prefs.getString('token') ?? "");
    if (userToken == "") {
      gotoLogin();
    } else {
      gotoHome();
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  gotoHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomTabsScreen()),
        (route) => false);
  }

  gotoLogin() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => loginpage()), (route) => false);
  }

  // gotoLogin() {
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) => Login_Page(title: '',)),
  //           (route) => false);
  // }
}
