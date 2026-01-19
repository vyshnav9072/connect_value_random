import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../navigation/bottomnavigation_screen.dart';
import '../resources/color.dart';
import '../services/login_service.dart';
import '../support/logger.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool hidePassword = true;
  bool _isLoader = false;

  String? email;
  String? password;
  bool _isLoading = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();


  // Future _login() async {
  //   var reqData = {
  //     'mobile': email,
  //     'password': password,
  //   };
  //   var response = await LoginService.login(reqData);
  //   log.i('Login page service. $response');
  //   print(response['id'].toString());
  //   _saveAndRedirectToHome(response['access_token'],response['user'].toString());
  //   gotoHome();
  // }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    var reqData = {
      'mobile': email,
      'password': password,
    };
    try {
      var response = await LoginService.login(reqData);
      if (response['sts'] == '01') {
        log.i('Login Success');
        print('User ID: ${response['id']}');
        print('Hr Id: ${response['hr_id']}');

        // _saveAndRedirectToHome(response['access_token'], response['name']);
        _saveAndRedirectToHome(response['access_token'],response['id'].toString(),response['hr_id'].toString());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Success'),
        ));
        gotoHome();
      }

      else {
        // log.e('Login failed: ${response['msg']}');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login failed: ${response['msg']}'),
        ));

        loginpage();
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _isLoader = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during login: $error'),
      ));
      log.e('Error during login: $error');
    }
  }

  void _saveAndRedirectToHome(usertoken, userId,hrId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", usertoken);
    await prefs.setString("userid", userId);
    await prefs.setString('hr_id', hrId);
  }

  gotoHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomTabsScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/svg/loginimg.svg',
                  width: 160,
                  height: 160,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Text(
                    "Welcome back to",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Seclob",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 55,
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    // controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Enter Your Email / phone',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                    onChanged: (text) {
                      setState(() {
                        email = text;
                      });
                    },
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: hidePassword, //show/hide password
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Enter Your Password',
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: hidePassword
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 48,
                width: 650,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(2, 109, 169, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: _isLoader
                      ? Transform.scale(
                          scale: 0.6,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Sign In',
                          style: TextStyle(color: bg),
                        ),
                  onPressed: () {
                    setState(() {
                      _login();
                      // _isLoader = true;
                      Navigator.of(context).pushAndRemoveUntil;
                    });
                    // _profileEditing();
                    print('complete_Login');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
