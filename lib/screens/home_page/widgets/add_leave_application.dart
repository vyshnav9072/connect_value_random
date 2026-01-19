import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../navigation/bottomnavigation_screen.dart';
import '../../../resources/color.dart';

import '../../../services/leaveapplication_service.dart';
import '../../../support/logger.dart';

class addleaveapplication extends StatefulWidget {
  const addleaveapplication({super.key});

  @override
  State<addleaveapplication> createState() => _addleaveapplicationState();
}

class _addleaveapplicationState extends State<addleaveapplication> {

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

  String? date;
  String? messages;
  String? day;



  Future createleave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    var reqData = {
      'user_id': userid,
      'from_date': date,
      'message':messages,
      // "status":"Pending",
      "type":'TeleCaller',
    };
    print(reqData);
    var response = await LeaveApplicationService.Createleave(reqData);
    log.i('leave create . $response');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomTabsScreen()),
    );

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


      body: Column(
        children: [

          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Pick date",style:TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
          ),

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
                      onTap: () async {
                        var selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            selecteddate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                            date = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"; // Format the date as needed for your API
                          });
                        }
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
                child: Text("Message",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
          ),

          SizedBox(height: 10,),

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
                      // hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 16,color: textColor),// Removed extra spaces
                      border: InputBorder.none, // Remove outline border
                    ),

                    onChanged: (text) {
                      setState(() {
                        messages=text;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("No: Of Days",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 40,
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
                      // hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 16,color: textColor),// Removed extra spaces
                      border: InputBorder.none, // Remove outline border
                    ),
                    onChanged: (text) {
                      setState(() {
                        day=text;

                      });
                    },
                  ),
                ),
              ),
            ),
          ),


          SizedBox(height: 40,),

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
                    createleave();
                  });
                  print('complete_Login');
                },
              ),
            ),
          ),

          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
