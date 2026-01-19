import 'package:flutter/material.dart';
import 'package:seclobstaff/screens/home_page/widgets/add_leave_application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/color.dart';
import '../../../services/leaveapplication_service.dart';
import '../../../support/logger.dart';
import 'edit_leave_application.dart';

class leaveapplication extends StatefulWidget {
  const leaveapplication({super.key});

  @override
  State<leaveapplication> createState() => _leaveapplicationState();
}

class _leaveapplicationState extends State<leaveapplication> {

  var userid;
  var leavelist;
  bool _isLoading = true;
  var status = '';


  Future leavelists(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print(userid);
    print(status);
    var reqData = {
      'user_id': userid,
      'status': status
    };
    var response = await LeaveApplicationService.LeaveList(reqData);
    log.i('Completed leave list page');
    setState(() {
      leavelist = response;
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
        leavelists(status)
      ],
    );
    _isLoading = false;
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Leave Application", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: true, // Display the back button
        iconTheme: IconThemeData(color: Colors.white), // Change the back button color to white
      ),

      body:  _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [

          SizedBox(height: 10,),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: GestureDetector(
          //       onTap: (){
          //
          //         showDialog<String>(
          //           context: context,
          //           builder: (BuildContext context) =>
          //               AlertDialog(
          //                 title:  Text('Select Data'),
          //
          //                 content: Container(
          //                   height: 340,
          //                   child: Column(
          //                     children: [
          //                       SizedBox(height: 20,),
          //                       GestureDetector(
          //                         onTap: (){
          //                           setState(() {
          //                             status = 'Pending';
          //                             leavelist(status);
          //                             Navigator.pop(context);
          //                             print(status);
          //                           });
          //                         },
          //                         child: Text(
          //                             'Pending'),
          //                       ),
          //
          //
          //                       Divider(),
          //                       SizedBox(height: 10,),
          //                       GestureDetector(
          //                         onTap: (){
          //                           status = 'Accepted';
          //                           leavelist(status);
          //                           Navigator.pop(context);
          //                         },
          //                         child: Text(
          //                             'Accepted'),
          //                       ),
          //                       Divider(),
          //                       SizedBox(height: 10,),
          //                       GestureDetector(
          //                         onTap: (){
          //                           status = 'Rejected';
          //                           leavelist(status);
          //                           Navigator.pop(context);
          //                         },
          //                         child: Text(
          //                             'Rejected'),
          //                       ),
          //                       Divider(),
          //                       SizedBox(height: 10,),
          //                     ],
          //                   ),
          //                 ),
          //                 actions: <Widget>[
          //
          //                   // TextButton(
          //                   //   onPressed: () {
          //                   //
          //                   //     Navigator.pop(context);
          //                   //   },
          //                   //   child:  Text(
          //                   //     'Submit',
          //                   //     style: TextStyle(
          //                   //         color: greenpermanat),
          //                   //   ),
          //                   // ),
          //                 ],
          //               ),
          //         );
          //       },
          //
          //       child: Container(
          //         height: 50,
          //         width: 50,
          //         decoration: BoxDecoration(
          //             color: bg,
          //
          //             borderRadius: BorderRadius.circular(10)
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 15),
          //           child: Icon(
          //             Icons.filter_list_outlined,
          //             color: Colors.black,
          //             size: 24.0,
          //             semanticLabel: 'filletr',
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 20,),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: leavelist['data'].length,
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



                            SizedBox(height: 5,),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(leavelist['data'][index]['from_date'].toString(),style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bggreay),),

                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => editleaveapplication(
                                        date:leavelist['data'][index]['from_date'],
                                          days:leavelist['data'][index]['days'].toString(),
                                       massage: leavelist['data'][index]['message'],
                                        id:leavelist['data'][index]['id'].toString(),

                                      )),
                                    );
                                  },
                                  child: Container(
                                    height: 18,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: r1,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Center(child: Text("Edit",style: TextStyle(fontSize: 8,color: bg),)),
                                  ),
                                )

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(leavelist['data'][index]['days'].toString(),style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bottomtabbg)),

                                Container(
                                  height: 18,
                                  width: 62,
                                  decoration: BoxDecoration(
                                    color: g1,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Center(child: Text(leavelist['data'][index]['status'],style: TextStyle(fontSize: 8,color: bg),)),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                leavelist['data'][index]['message'],
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: bottomtabbg),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 15,)
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
            MaterialPageRoute(builder: (context) =>  addleaveapplication()),
          );
        },
        child: const Icon(Icons.add,color: bg,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}
