import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seclobstaff/services/leads_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../navigation/bottomnavigation_screen.dart';
import '../../../resources/color.dart';
import '../../../support/logger.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class addleads extends StatefulWidget {
   addleads({super.key,});



  @override
  State<addleads> createState() => _addleadsState();
}

class _addleadsState extends State<addleads> {
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

  String dropdownValue = 'New';

  List<String> spinnerItems = [
    'New',
    'Following',
    'Pending',
    'Complted',
    'Ongoing',
    'Not responding',
    'Cancelled',
    'Deleted',
  ];

  String selectedItem = 'Option 1';

  List statelead = [];
  List districtlead = [];
  List servicelead = [];

  var statedropdownvalue;
  var districtdropdownvalue;
  List<dynamic> servicedropdownvalue = [];

  // var servicedropdownvalue;

  String? leadname;
  String? mobilenumber;
  String? companyname;
  String? description;

  var userid;
  var hrid;



  Future _getstates() async {
    var response = await LeadService.LeadPageStates();
    log.i('state list.. $response');
    setState(() {
      statelead = response['states'];
    });
  }

  Future _getdistrict() async {
    var response = await LeadService.LeadPageDistrict();
    log.i('district list. $response');
    setState(() {
      districtlead = response['districts'];
    });
    print(districtlead);
  }

  Future _getservice() async {
    var response = await LeadService.LeadPageservice();
    log.i('service list. $response');
    setState(() {
      servicelead = response['services'];
    });
  }

  Future createalead() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    hrid=prefs.getString('hr_id');
    print(userid);
    print(hrid);
    var reqData = {
      'telle_id': userid,
      'hr_id' : hrid,
      'name' : leadname,
      'mobile' : mobilenumber,
      'company':companyname,
      'status':dropdownValue,
      'state_id': statedropdownvalue['id'],
      'district_id' : districtdropdownvalue['id'],
      'services': servicedropdownvalue.map((item) => item['id']).toList(),
      'telle_desc' :description,
    };
    var response = await LeadService.Createlead(reqData);
    log.i('Lead create service. $response');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomTabsScreen()),
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getstates();
    _getdistrict();
    _getservice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Add Leads", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: true,
        // Display the back button
        iconTheme: IconThemeData(
            color: Colors.white), // Change the back button color to white
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Lead Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12))),
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.only(left: 12, bottom: 7),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter lead name",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                    ),
                    onChanged: (text) {
                      setState(() {
                        leadname=text;

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
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Company Name",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.only(left: 12, bottom: 7),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter company name",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                    ),

                    onChanged: (text) {
                      setState(() {
                        companyname=text;

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
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Contact number",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.only(left: 12, bottom: 7),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter contact number",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                    ),

                    onChanged: (text) {
                      setState(() {
                        mobilenumber=text;

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
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "State",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
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
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                          hintText: 'Select State',
                          hintStyle: TextStyle(fontSize: 12,color: graytext)// Remove underline
                      ),
                      isExpanded: true,
                      dropdownColor: bg1,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: graytext,
                      ),
                      iconSize: 20,
                      elevation: 10,
                      style: TextStyle(color: graytext, fontSize: 15),
                      items: statelead.map((item) {
                        print(item);
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item['name'].toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          statedropdownvalue = newVal;
                        });
                      },
                      value: statedropdownvalue,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "District",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
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
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Select District',
                        hintStyle: TextStyle(fontSize: 12,color: graytext)// Remove underline
                      ),
                      isExpanded: true,
                      dropdownColor: bg1,
                      icon: Icon(Icons.arrow_drop_down, color: graytext),
                      iconSize: 20,
                      elevation: 10,
                      style: TextStyle(color: graytext, fontSize: 15),
                      items: districtlead.map((item) {
                        print(item);
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item['name'].toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          districtdropdownvalue = newVal;
                        });
                      },
                      value: districtdropdownvalue,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Choose Status",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
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
                    color: graybg, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
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
                    style: TextStyle(color: graytext, fontSize: 15),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? data) {
                      // Change the parameter type to String?
                      setState(() {
                        dropdownValue = data ?? '';
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Service type",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: graybg,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MultiSelectDialogField(
                  items: servicelead
                      .map((item) =>
                      MultiSelectItem(item, item['label'].toString()))
                      .toList(),
                  title: Text('Select Services'),
                  buttonText: Text('Select one or more services',style: TextStyle(fontSize: 12,color: graytext),),
                  onConfirm: (values) {
                    setState(() {
                      servicedropdownvalue = values; // Update the selected items
                    });
                  },
                  buttonIcon: Icon(
                    Icons.arrow_drop_down,
                    color: graytext,
                    size: 20,
                  ), // Set the icon to null to remove it
                  decoration: BoxDecoration(
                    // Set a custom decoration without an underline
                    border: Border.all(color: Colors.transparent),
                    // Make the border transparent
                    borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius
                  ),
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
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: graybg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      textAlign: TextAlign.start, // Center-align the hint text
                      decoration: InputDecoration(
                        hintText: 'Enter Your Decription ', // Add hint text here
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        border: InputBorder.none, // Remove outline border
                      ),
                      onChanged: (text) {
                        setState(() {
                          description = text;
                        });
                      },
                    ),
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(15, 63, 84, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      createalead();
                      print(userid);
                    });

                  },
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
