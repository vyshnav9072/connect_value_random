import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../navigation/bottomnavigation_screen.dart';
import '../../../resources/color.dart';
import '../../../services/following_lead_service.dart';
import '../../../support/logger.dart';

class followuplead extends StatefulWidget {
   followuplead({super.key,required this.id});

   String? id;

  @override
  State<followuplead> createState() => _followupleadState();
}

class _followupleadState extends State<followuplead> {

  var userid;
  String? description;
  String? date;



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




  String dropdownValue = 'Active';

  List<String> spinnerItems = [
    'Active',
    'Completed',
    'Pending',
    'Re-Sheduled',
  ];


  Future<void> statuscommentsupdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print('..............userId=$userid');
    var reqData = {
      'id': widget.id,
      'telle_id':userid,
      "description": description,
      "follow_date": date,
      "status":dropdownValue,
    };
    try {
      var response = await FollowingService.Followleadcreate(reqData, widget.id);
      log.i('Following lead create. $response');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomTabsScreen()),
      );
    } catch (error) {
      print('Error Following lead: $error');
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Follow up lead", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: true,
        // Display the back button
        iconTheme: IconThemeData(
            color: Colors.white), // Change the back button color to white
      ),

      body: Column(
        children: [

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

          SizedBox(height: 10,),

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


          SizedBox(height: 10,),


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
                  print(widget.id);
                  statuscommentsupdate();

                  });

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => followuplead(id: widget.id),
                    ),
                  );

                },
              ),
            ),
          ),



        ],
      ),

    );
  }
}
