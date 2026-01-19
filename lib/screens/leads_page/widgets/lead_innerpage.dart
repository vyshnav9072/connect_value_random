import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/color.dart';
import '../../../services/leads_service.dart';
import '../../../support/logger.dart';
import '../../followingleads_page/widgets/followup_lead_create.dart';
import 'add_leads_page.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class leadinner extends StatefulWidget {
  leadinner({super.key, required this.id});

  String? id;

  @override
  State<leadinner> createState() => _leadinnerState();
}

class _leadinnerState extends State<leadinner> {
  // String dropdownValue = 'Pending';
  String? selectedValue;
  TextEditingController textFieldController = TextEditingController();

  // List <String> spinnerItems = [
  //   'Pending',
  //   'Complted',
  // ];

  String dropdownValue = 'New';

  List<String> spinnerItems = [
    'New',
    'Pending',
    'Following',
    'Not Responding',
    'Cancelled',
    'Completed',
    'Deleted',
  ];

  var Leadinner;
  bool _isLoading = true;
  var userid;
  var hrid;
  String? comment;
  String? amount;


  Future _Leadinnerpage() async {
    var response = await LeadService.LeadInnerPage(widget.id);
    log.i('Profile page. $response');
    setState(() {
      Leadinner = response;
    });
  }



  Future<void> statuscommentsupdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    hrid = prefs.getString('hr_id');
    print('..............userId=$userid');
    print('...............hrId=$hrid');
    var reqData = {
      'id': widget.id,
      'tc_id':userid,
      'hr_id':hrid,
      'comments': comment,
      "status": "Pending",
    };
    try {
      var response = await LeadService.LeadCommentsAddPage(reqData, widget.id);
      log.i('Status comments updated. $response');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Status comments updated'),
      // ));
    } catch (error) {
      print('Error editing work report: $error');
    }
  }

  Future<void> leadammountupdateddate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    hrid = prefs.getString('hr_id');
    var reqData = {
      'id': widget.id,
      'amount':amount,
    };
    try {
      var response = await LeadService.LeadAmountAddPage(reqData, widget.id);
      log.i('Lead Amount updated. $response');
      print('API Response: $response');
    } catch (error) {
      print('Error updating lead status and comments: $error');
    }
  }


  Future<void> leadstatuschange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print(dropdownValue);
    var reqData = {
      'id': widget.id,
      'status':dropdownValue,
    };
    try {
      var response = await LeadService.Leadstatusupdate(reqData, widget.id);
      log.i('Lead status updated. $response');
      print('API Response: $response');
    } catch (error) {
      print('Error lead status : $error');
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initLoad();
  }

  Future _initLoad() async {
    await Future.wait(
      [_Leadinnerpage()],
    );
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text('lead Inner', style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: true,
        // Display the back button
        iconTheme: IconThemeData(
            color: Colors.white), // Change the back button color to white
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
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
                          SizedBox(
                            height: 40,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  Leadinner['users'][0]['name'],
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      color: bottomtabbg),
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 15,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    Leadinner['users'][0]['created_at'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: graytext),
                                  ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                Leadinner['users'][0]['company'],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: bottomtabbg),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  Leadinner['users'][0]['mobile'],
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: graytext),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  Leadinner['users'][0]['amount'],
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  Leadinner['users'][0]['address'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: bottomtabbg),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                Leadinner['users'][0]['status'],
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                Leadinner['users'][0]['comments'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: bottomtabbg),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 26,
                                width: 146,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(15, 63, 84, 1)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Click to Call',
                                    style: TextStyle(color: bg),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      FlutterPhoneDirectCaller.callNumber(
                                          Leadinner['users'][0]['mobile']);
                                    });
                                    // _profileEditing();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                height: 26,
                                width: 146,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(255, 0, 0, 1)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(color: bg),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => addleads()),
                                      );
                                    });
                                    // _profileEditing();
                                    print('complete_Login');
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                )),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 20),
                          //   child: Container(
                          //     height: 40,
                          //     decoration: BoxDecoration(
                          //       color: graybg,
                          //       borderRadius: BorderRadius.all(Radius.circular(5)),
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.symmetric(horizontal: 20),
                          //       child: DropdownButton<String?>(
                          //         isExpanded: true,
                          //         value: selectedValue,
                          //         dropdownColor: bg1,
                          //         icon: Icon(Icons.arrow_drop_down,color: graytext,),
                          //         iconSize: 20,
                          //         elevation: 10,
                          //         style: TextStyle(color:graytext, fontSize: 15),
                          //         underline: Container(
                          //           height: 2,
                          //           color: Colors.transparent,
                          //         ),
                          //         items: <String?>[ 'New','Pending','Following','Not Responding','Cancelled','Completed','Deleted']
                          //             .map((String? value) {
                          //           return DropdownMenuItem<String?>(
                          //             value: value,
                          //             child: Text(value ?? ''), // Provide a default value if null
                          //           );
                          //         }).toList(),
                          //         onChanged: (String? newValue) { // Change the type to String?
                          //           setState(() {
                          //             selectedValue = newValue;
                          //             if (selectedValue != 'Completed') {
                          //               // Clear the text field when a different option is selected
                          //               textFieldController.clear();
                          //             }
                          //           });
                          //         },
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
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  dropdownColor: bg1,
                                  value: dropdownValue,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: graytext,
                                  ),
                                  iconSize: 20,
                                  elevation: 10,
                                  style:
                                      TextStyle(color: graytext, fontSize: 15),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (String? data) {
                                    // Change the parameter type to String?
                                    setState(() {
                                      dropdownValue = data ?? '';

                                      selectedValue = data;
                                      if (selectedValue != 'Completed') {
                                        textFieldController.clear();
                                      }
                                    });
                                  },
                                  items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),


                          Visibility(
                            visible: selectedValue == 'Completed',
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Add Amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: graybg,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 12, bottom: 7),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "Enter Ammount",
                                          hintStyle: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                        ),
                                        onChanged: (text) {
                                          setState(() {
                                            amount=text;

                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),



                          if(selectedValue=='Following')
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                height: 48,
                                width: 650,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(15, 63, 84, 1)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Followup',
                                    style: TextStyle(color: bg),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => followuplead(

                                        id:Leadinner['users'][0]['id'].toString(),

                                      )),
                                    );
                                  },
                                ),
                              ),
                            ),

                          SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Add Status Change Comments",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                )),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: graybg,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                padding: EdgeInsets.only(left: 12, bottom: 7),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Status Change Comments ",
                                    hintStyle: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                  ),

                                  onChanged: (text) {
                                    setState(() {
                                      comment=text;

                                    });
                                  },

                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 48,
                              width: 650,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(15, 63, 84, 1)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: bg),
                                ),
                                onPressed: () {
                                  setState(() {
                                    statuscommentsupdate();
                                    leadammountupdateddate();
                                    leadstatuschange();

                                  });

                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => leadinner(id: widget.id),
                                    ),
                                  );

                                },
                              ),
                            ),
                          ),


                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
