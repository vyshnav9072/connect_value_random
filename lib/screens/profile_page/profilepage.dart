import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../authentication/login_page.dart';
import '../../resources/color.dart';
import '../../services/profile_service.dart';
import '../../support/logger.dart';

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {


  var profilepageapi;
  String? userid;


  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => loginpage()),
    // );
  }

  Future _profilepage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = (prefs.getString('userid') ?? "");
    print("userid....$userid");
    var response = await ProfileService.profilePage(userid);
    log.i('Profile page. $response');

    setState(() {
      profilepageapi = response;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profilepage();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Profile", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: false, // Display the back button
        iconTheme: IconThemeData(color: Colors.white), // Change the back button color to white
      ),

      body: Column(
        children: [

          SizedBox(height: 20,),

          Center(
            child: Container(
              height: 120,
              width: 315,
              decoration: BoxDecoration(
                  color: gray,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(profilepageapi != null ?  profilepageapi['users'][0]['name']:"loading...",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  Text(profilepageapi != null ?  profilepageapi['users'][0]['email']:"loading...",style: TextStyle(fontSize: 15,),),
                  Text(profilepageapi != null ?  profilepageapi['users'][0]['mobile']:"loading...",style: TextStyle(fontSize: 15,),),
                ],
              )),

            ),
          ),

          SizedBox(height: 50,),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Align(
          //       alignment: Alignment.topLeft,
          //       child: Text("Dashboard",style: TextStyle(color: graytext,fontSize: 15),)),
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: ExpansionTile(
              title: Text('Settings'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Text('Logout',style: TextStyle(fontSize: 14,color: r1),),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => loginpage()),
                              (route) => false);

                      logout();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



