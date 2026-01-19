import 'package:flutter/material.dart';
import 'package:seclobstaff/screens/followingleads_page/widgets/followinglead_inner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widgets/search.dart';
import '../../resources/color.dart';
import '../../services/following_lead_service.dart';
import '../../support/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';


class followingleads extends StatefulWidget {
  const followingleads({super.key});

  @override
  State<followingleads> createState() => _ticketpageState();
}

class _ticketpageState extends State<followingleads> {

  String dropdownValue = 'Pending';

  List <String> spinnerItems = [
    'Pending',
    'Complted',
  ];


  Future getshowDatePicker() async {
    var selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    return selected;
  }

  String selecteddate = "Select Date";
  var userid;
  var followgrid;
  bool _isLoading = true;
  String? date;



  Future homepagegrid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print(userid);
    var reqData = {
      'user_id': userid,
    };
    var response = await FollowingService.Followlead(reqData);
    log.i('Completed home page');
    setState(() {
      followgrid = response;
      print(response);
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
        homepagegrid()
      ],
    );
    _isLoading = false;
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Following Lead", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: false, // Display the back button
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  searchpage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),

      body: _isLoading
          ? Shimmer.fromColors(
        baseColor: greybg, // The color of the shimmer effect when not active
        highlightColor: textgray, // The color of the shimmer highlight when not active
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Column(
        children: [

          SizedBox(height: 20,),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Container(
          //     height: 30,
          //     decoration: BoxDecoration(
          //         color: graybg, borderRadius: BorderRadius.circular(10)),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 30),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text("$selecteddate"),
          //           GestureDetector(
          //             onTap: () {
          //               getshowDatePicker().then((value) {
          //                 if (value != null) {
          //                   setState(() {
          //                     var date = DateTime.parse(value.toString());
          //                     selecteddate =
          //                     "${date.day}-${date.month}-${date.year}";
          //                   });
          //                 }
          //               });
          //             },
          //             child: Icon(
          //               Icons.date_range,
          //               color: textgray,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          SizedBox(height: 20,),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  followingleadinner(
                  //
                  //   id:followgrid['leadsFollowUp'][0]['id'].toString(),
                  //   fid:followgrid['leadsFollowUp'][0]['fid'].toString(),
                  //
                  // )));
                },
                child: ListView.builder(
                  itemCount: followgrid['leadsFollowUp'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0), // Add bottom spacing
                      child: Container(
                        height: 110,
                        width: 320,
                        decoration: BoxDecoration(
                            color: expencepagebg,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(followgrid['leadsFollowUp'][index]['name'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: bottomtabbg),),

                                  Container(
                                    height: 18,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: g1,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Center(child: Text(followgrid['leadsFollowUp'][index]['followstatus'],style: TextStyle(fontSize: 8,color: bg),)),
                                  )
                                ],
                              ),

                              Text(followgrid['leadsFollowUp'][index]['amount'],style: TextStyle(fontSize: 11,fontWeight: FontWeight.w900,color: bggreay),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(followgrid['leadsFollowUp'][index]['mobile'],style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bggreay)),

                                  InkWell(
                                    onTap: (){
                                      FlutterPhoneDirectCaller.callNumber(followgrid['leadsFollowUp'][index]['mobile']);
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        color: gradient1,
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                      ),
                                      child: Center(child: Text("clicktocall",style: TextStyle(fontSize: 8,color: bg),)),
                                    ),
                                  )
                                ],
                              ),

                              Text(
                                followgrid['leadsFollowUp'][index]['description'],
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: bggreay,
                                ),
                                maxLines: 2, // Limit to two lines
                                overflow: TextOverflow.ellipsis, // Display ellipsis when text overflows
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}