import 'package:flutter/material.dart';
import 'package:seclobstaff/screens/expence_page/widgets/add_expence_page.dart';
import 'package:seclobstaff/screens/expence_page/widgets/edit_expence_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../resources/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/expence_service.dart';
import '../../support/logger.dart';

class expencepage extends StatefulWidget {
  const expencepage({super.key});

  @override
  State<expencepage> createState() => _expencepageState();
}

class _expencepageState extends State<expencepage> {

  String dropdownValue = 'Pending';

  var userid;
  var expancelist;
  bool _isLoading = true;


  List <String> spinnerItems = [
    'Pending',
    'Complted',
    'Ongoing',
  ];



  Future expancelists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print(userid);
    var reqData = {
      'user_id': userid,
    };
    var response = await ExpenceService.ExpenceList(reqData);
    log.i('Completed lead list page');
    setState(() {
      expancelist = response;
      print(response);
      print('................USER IDDDDDD$userid');
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
        expancelists()
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
        title: Text("Expenses", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: false, // Display the back button
        iconTheme: IconThemeData(color: Colors.white), // Change the back button color to white
      ),
      body:  _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [

          SizedBox(height: 20,),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         color: b1,
          //         height: 30,
          //         width: 170,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //
          //             Text("filter by status :",style: TextStyle(color: Colors.grey, fontSize: 12),),
          //
          //             DropdownButton<String>(
          //               value: dropdownValue,
          //               icon: Icon(Icons.arrow_drop_down),
          //               iconSize: 24,
          //               elevation: 16,
          //               style: TextStyle(color: Colors.black, fontSize: 12),
          //               underline: Container(
          //                 height: 2,
          //                 color: Colors.transparent,
          //               ),
          //               onChanged: (String? data) { // Change the parameter type to String?
          //                 setState(() {
          //                   dropdownValue = data ?? ''; // Use a default value in case data is null
          //                 });
          //               },
          //               items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
          //                 return DropdownMenuItem<String>(
          //                   value: value,
          //                   child: Text(value),
          //                 );
          //               }).toList(),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         color: b1,
          //         height: 30,
          //         width: 170,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //
          //             Text("filter by date :",style: TextStyle(color: Colors.grey, fontSize: 12),),
          //
          //             DropdownButton<String>(
          //               value: dropdownValue,
          //               icon: Icon(Icons.arrow_drop_down),
          //               iconSize: 24,
          //               elevation: 16,
          //               style: TextStyle(color: Colors.black, fontSize: 12),
          //               underline: Container(
          //                 height: 2,
          //                 color: Colors.transparent,
          //               ),
          //               onChanged: (String? data) { // Change the parameter type to String?
          //                 setState(() {
          //                   dropdownValue = data ?? ''; // Use a default value in case data is null
          //                 });
          //               },
          //               items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
          //                 return DropdownMenuItem<String>(
          //                   value: value,
          //                   child: Text(value),
          //                 );
          //               }).toList(),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //
          //   ],
          // ),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: expancelist['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0), // Add bottom spacing
                    child: Container(

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

                            SizedBox(height: 10,),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => editexpance(
                                    km: expancelist['data'][index]['km'],
                                    id:expancelist['data'][index]['id'].toString(),
                                    expance:expancelist['data'][index]['amount'],
                                    day:expancelist['data'][index]['day'],
                                     toplace:expancelist['data'][index]['to_place'],
                                    vechile:expancelist['data'][index]['vechicle'],
                                      fromplace:expancelist['data'][index]['from_place'],
                                    desription:expancelist['data'][index]['from_place'],

                                  )),
                                );

                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child:  Icon(Icons.more_vert),
                              ),
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Row(
                                  children: [
                                    Container(
                                        width:45,
                                        height: 20,
                                        child: Text(expancelist['data'][index]['vechicle'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: bottomtabbg),)),
                                    SizedBox(width: 28,),
                                    Container(
                                      height: 12,
                                        width: 12,
                                        decoration: BoxDecoration(
                                          color: green,
                                            borderRadius: BorderRadius.all(Radius.circular(100))
                                        ),
                                    ),
                                    SizedBox(width: 5,),
                                    Icon(Icons.location_on,size: 8,),
                                    SizedBox(width: 5,),
                                    Text(expancelist['data'][index]['from_place'],style: TextStyle(fontSize: 10),)
                                  ],
                                ),
                                Text('₹ ${expancelist['data'][index]['amount']}',),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(expancelist['data'][index]['km'],style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bggreay),),

                                    SizedBox(width: 60,),

                                    SvgPicture.asset(
                                      'assets/svg/locationtwo.svg',
                                      width: 10,
                                      height: 10,
                                    ),

                                  ],
                                ),

                                Container(
                                  height: 18,
                                  width: 62,
                                  decoration: BoxDecoration(
                                    color: r1,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Center(child: Text(expancelist['data'][index]['status'],style: TextStyle(fontSize: 8,color: bg),)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width:60,
                                        height: 10,
                                        child: Text(expancelist['data'][index]['day'],style: TextStyle(fontSize: 9,fontWeight: FontWeight.w500,color: bggreay))),

                                    SizedBox(width: 14,),
                                    Container(
                                      height: 12,
                                      width: 12,
                                      decoration: BoxDecoration(
                                          color: r1,
                                          borderRadius: BorderRadius.all(Radius.circular(100))
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Icon(Icons.location_on,size: 8,),
                                    SizedBox(width: 5,),
                                    Text(expancelist['data'][index]['to_place'],style: TextStyle(fontSize: 10),),


                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 10,),

                            Text(
                              expancelist['data'][index]['description'],
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis, // or TextOverflow.clip for truncation
                              maxLines: 1, // Adjust this value to control the number of lines displayed
                            ),

                            SizedBox(height: 10,),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: bottomtabbg,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  addexpence()),
          );
        },
        child: const Icon(Icons.add,color: bg,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


