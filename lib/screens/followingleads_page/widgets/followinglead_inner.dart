import 'package:flutter/material.dart';

import '../../../resources/color.dart';
import '../../../services/following_lead_service.dart';
import '../../../support/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class followingleadinner extends StatefulWidget {
   followingleadinner({super.key,required this.id,required this.fid});

   String? id;
   String? fid;


  @override
  State<followingleadinner> createState() => _leadinnerState();
}

class _leadinnerState extends State<followingleadinner> {

  String dropdownValue = 'Pending';
  String? selectedValue;
  TextEditingController textFieldController = TextEditingController();


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



  List <String> spinnerItems = [
    'Pending',
    'Complted',
  ];

  var userid;
  var fid;



  Future<void> statuscommentsupdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    fid = prefs.getString('hr_id');
    print('..............userId=$userid');

    var reqData = {
      'id': widget.id,

      "status":"Pending"
    };
    try {
      var response = await FollowingService.Followleadstatusupdate(reqData, widget.id,widget.fid);
      log.i('Status comments updated. $response');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Status comments updated'),
      // ));
    } catch (error) {
      print('Error editing work report: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("following Lead Inner", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: true,
        // Display the back button
        iconTheme: IconThemeData(
            color: Colors.white), // Change the back button color to white
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(

              width: 400,
              decoration: BoxDecoration(
                  color: expencepagebg,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [

                  SizedBox(height: 40,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Nayana",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: bottomtabbg),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "10.09.2022",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: graytext),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "9074343614",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: graytext),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Enquries",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: graytext),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Kozhikode",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: bottomtabbg),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Kerala",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: bottomtabbg),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Status",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: bottomtabbg),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: bottomtabbg),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),


                  SizedBox(height: 30,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 26,
                        width: 146,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(15, 63, 84, 1)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child:  Text(
                            'Click to Call',
                            style: TextStyle(color: bg),
                          ),
                          onPressed: () {
                            setState(() {


                            });
                            // _profileEditing();
                            print('complete_Login');
                          },
                        ),
                      ),

                      SizedBox(width: 15,),

                      SizedBox(
                        height: 26,
                        width: 146,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(255, 0, 0, 1)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child:  Text(
                            'Edit',
                            style: TextStyle(color: bg),
                          ),
                          onPressed: () {
                            setState(() {

                              statuscommentsupdate();
                              print(widget.id);
                              print(widget.fid);
                            });

                          },
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 10,),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Status",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
                  ),

                  SizedBox(height: 10,),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Container(
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       color: graybg,
                  //       borderRadius: BorderRadius.all(Radius.circular(5)),
                  //     ),
                  //     child: Center(
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 35),
                  //         child: DropdownButton<String>(
                  //           isExpanded: true,
                  //           dropdownColor: bg1,
                  //           value: dropdownValue,
                  //           icon: Icon(Icons.arrow_drop_down,color: graytext,),
                  //           iconSize: 20,
                  //           elevation: 10,
                  //           style: TextStyle(color:graytext, fontSize: 15),
                  //           underline: Container(
                  //             height: 2,
                  //             color: Colors.transparent,
                  //           ),
                  //           onChanged: (String? newValue) { // Change the type to String?
                  //             setState(() {
                  //               selectedValue = newValue;
                  //               if (selectedValue != 'Complete') {
                  //                 // Clear the text field when a different option is selected
                  //               }
                  //             });
                  //           },
                  //           items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                  //             return DropdownMenuItem<String>(
                  //               value: value,
                  //               child: Text(value,style: TextStyle(fontSize: 12,),),
                  //             );
                  //           }).toList(),
                  //         ),
                  //
                  //       ),
                  //     ),
                  //   ),
                  // ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: graybg,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton<String?>(
                          isExpanded: true,
                          value: selectedValue,
                          dropdownColor: bg1,
                          icon: Icon(Icons.arrow_drop_down,color: graytext,),
                          iconSize: 20,
                          elevation: 10,
                          style: TextStyle(color:graytext, fontSize: 15),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          items: <String?>[ 'ongoing', 'pending', 'Complete']
                              .map((String? value) {
                            return DropdownMenuItem<String?>(
                              value: value,
                              child: Text(value ?? ''), // Provide a default value if null
                            );
                          }).toList(),
                          onChanged: (String? newValue) { // Change the type to String?
                            setState(() {
                              selectedValue = newValue;
                              if (selectedValue != 'Complete') {
                                // Clear the text field when a different option is selected
                                textFieldController.clear();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Visibility(
                    visible: selectedValue == 'Complete',
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Add Amount",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: graybg,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            padding:EdgeInsets.symmetric(horizontal: 20),
                            child:Container(
                              padding:EdgeInsets.only(left:12,bottom: 7),
                              child: TextFormField(
                                decoration:InputDecoration(
                                  hintText:"Enter Ammount",
                                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                  border:InputBorder.none,
                                  fillColor:Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),



                  SizedBox(height: 10,),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Following Date",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
                  ),

                  SizedBox(height: 10,),


                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: graybg, borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$selecteddate"),
                            GestureDetector(
                              onTap: () {
                                getshowDatePicker().then((value) {
                                  if (value != null) {
                                    setState(() {
                                      var date = DateTime.parse(value.toString());
                                      selecteddate =
                                      "${date.day}-${date.month}-${date.year}";
                                    });
                                  }
                                });
                              },
                              child: Icon(
                                Icons.date_range,
                                color: textgray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),




                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Add Status Change Comments",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
                  ),

                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: graybg,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      padding:EdgeInsets.symmetric(horizontal: 20),
                      child:Container(
                        padding:EdgeInsets.only(left:12,bottom: 7),
                        child: TextFormField(
                          decoration:InputDecoration(
                            hintText:"Status Change Comments ",
                            hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                            border:InputBorder.none,
                            fillColor:Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 48,
                      width: 650,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(15, 63, 84, 1)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child:  Text(
                          'Submit',
                          style: TextStyle(color: bg),
                        ),
                        onPressed: () {
                          setState(() {


                          });
                          // _profileEditing();
                          print('complete_Login');
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 35,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
