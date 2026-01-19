import 'package:flutter/material.dart';
import 'package:seclobstaff/screens/home_page/widgets/attendance_page.dart';
import 'package:seclobstaff/screens/home_page/widgets/leave_application.dart';
import 'package:seclobstaff/screens/home_page/widgets/notification_page.dart';
import 'package:seclobstaff/screens/home_page/widgets/work_report/work_report.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../authentication/splash_screen.dart';
import '../../navigation/test.dart';
import '../../resources/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/home_service.dart';
import '../../services/profile_service.dart';
import '../../support/logger.dart';

class home extends StatefulWidget {
  home({super.key,});


  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {


  var homegrid;
  var userid;
  var profilepageapi;
  bool _isLoading = true;


  Future homepagegrid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print(userid);
    var reqData = {
      'user_id': userid,
    };
    var response = await HomeService.homegrid(reqData);
    log.i('Completed home page');
    setState(() {
      homegrid = response;
      print(response);
    });
  }

  Future profilepage() async {
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
    _initLoad();
  }

  Future _initLoad() async {
    await Future.wait(
      [
    homepagegrid(),
    profilepage(),

      ],
    );
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: _isLoading
          ? Shimmer.fromColors(
        baseColor: greybg, // The color of the shimmer effect when not active
        highlightColor: textgray, // The color of the shimmer highlight when not active
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Welcome",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      profilepageapi['users'][0]['name'],
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => notification()),
                    );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LocationTracker()),
                    // );

                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.black,
                              size: 35,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 3,left: 5),
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: r1,
                                    border: Border.all(color: Colors.white, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Center(
                                    child: Text(
                                      "1",
                                      style: TextStyle(fontSize: 10,color: bg),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3.0,
                      offset: Offset(0.0, 3.0)),
                ],
                color: bg,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        homegrid['dailyTarget'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: textColor,
                        ),
                      ),
                      Text(
                        "Todays Target",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: textColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 20,),
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3.0,
                      offset: Offset(0.0, 3.0)),
                ],
                color: bg,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        homegrid['monthlyTarget'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: textColor,
                        ),
                      ),
                      Text(
                        "Monthly Target",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: textColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['leadsMonthIncome'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Month Income",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['leadsMonthExpense'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Month Expense",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),


            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['leadsTodayIncome'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Todays Income",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['leadsTodayIncome'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Todays Expense",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['leadsIncome'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Total Income",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['leadsMonthExpense'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Total Expense",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['totalLeads'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Total Leads",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['new'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "New Leads",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['pending'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Pending Leads",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['following'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Following Leads",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['notresponding'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Not Responding Leads",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['cancelled'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Cancelled Leads",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['completed'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Completed Leads",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0)),
                    ],
                    color: bg,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homegrid['deleted'].toString(), // Provide a fallback value if 'dailyTarget' is not available
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Deleted Leads",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => attendancepage()),
                );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  MyHomePage1()),
                // );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 73,
                  width: 400,
                  decoration: BoxDecoration(
                      color: bottomtabbg,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        //         SvgPicture.asset(
                        //         'assets/svg/attendence.svg',
                        //         width: 35,
                        //         height: 35,
                        //         fit: BoxFit.scaleDown,
                        // ),

                        SizedBox(
                          width: 20,
                        ),

                        Text(
                          "Mark your attendance",
                          style: TextStyle(color: bg, fontSize: 14),
                        ),

                        Expanded(child: SizedBox()),

                        Container(
                          height: 32,
                          width: 77,
                          decoration: BoxDecoration(
                              color: bg,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                              child: Text(
                            "Check in",
                            style: TextStyle(
                                color: textcolor, fontWeight: FontWeight.w600),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => workreport()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 73,
                  width: 400,
                  decoration: BoxDecoration(
                      color: bottomtabbg,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        // SvgPicture.asset(
                        //   'assets/svg/report.svg',
                        //   width: 35,
                        //   height: 35,
                        //   fit: BoxFit.scaleDown,
                        // ),

                        SizedBox(
                          width: 20,
                        ),

                        Text(
                          "Add your work report",
                          style: TextStyle(color: bg, fontSize: 14),
                        ),

                        Expanded(child: SizedBox()),

                        Container(
                          height: 32,
                          width: 77,
                          decoration: BoxDecoration(
                              color: bg,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                              child: Text(
                            "View",
                            style: TextStyle(
                                color: textcolor, fontWeight: FontWeight.w600),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => leaveapplication()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 73,
                  width: 400,
                  decoration: BoxDecoration(
                      color: bottomtabbg,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        // SvgPicture.asset(
                        //   'assets/svg/report.svg',
                        //   width: 35,
                        //   height: 35,
                        //   fit: BoxFit.scaleDown,
                        // ),

                        SizedBox(
                          width: 20,
                        ),

                        Text(
                          "Leave application",
                          style: TextStyle(color: bg, fontSize: 14),
                        ),

                        Expanded(child: SizedBox()),

                        Container(
                          height: 32,
                          width: 77,
                          decoration: BoxDecoration(
                              color: bg,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                              child: Text(
                            "View",
                            style: TextStyle(
                                color: textcolor, fontWeight: FontWeight.w600),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
