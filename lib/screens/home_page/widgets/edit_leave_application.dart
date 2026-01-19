import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../navigation/bottomnavigation_screen.dart';
import '../../../resources/color.dart';
import '../../../services/leaveapplication_service.dart';
import '../../../support/logger.dart';

class editleaveapplication extends StatefulWidget {
   editleaveapplication({super.key,required this.date,required this.days,required this.massage,required this.id});

  final String date;
  final String days;
  final String massage;
  final String id;

  @override
  State<editleaveapplication> createState() => _editleaveapplicationState();
}

class _editleaveapplicationState extends State<editleaveapplication> {


  TextEditingController dateController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController massageController = TextEditingController();

  late String date;
  late String days;
  late String massage;

  var userid;




  @override
  void initState() {
    super.initState();
    days = widget.days;
    date=widget.date;
    massage=widget.massage;




    daysController.text = days;
    dateController.text=date;
    massageController.text=massage;


  }

  Future<void> editleave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print(widget.id);
    var reqData = {
      'message': massageController.text,
      'days':daysController.text,
      'from_date': dateController.text,
      "status":"Pending"
    };

    try {
      var response = await LeaveApplicationService.LeaveApplicationEdit(reqData, widget.id);
      log.i('successfully leave editing page. $response');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomTabsScreen()),
      );

    } catch (error) {
      print('Error editing expance editing: $error');
    }
  }



  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Edit Leave Application", style: TextStyle(color: bg)),
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
                child: Text("Date",style:TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
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
                    textAlign: TextAlign.start,
                    controller: dateController,// Center-align the hint text
                    decoration: InputDecoration(
                      // hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 16,color: textColor),// Removed extra spaces
                      border: InputBorder.none, // Remove outline border
                    ),

                    onChanged: (text) {
                      setState(() {
                        days=text;

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
                    controller: massageController,
                    textAlign: TextAlign.start, // Center-align the hint text
                    decoration: InputDecoration(
                      // hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 16,color: textColor),// Removed extra spaces
                      border: InputBorder.none, // Remove outline border
                    ),

                    onChanged: (text) {
                      setState(() {
                        massage=text;

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
                    controller: daysController,
                    textAlign: TextAlign.start, // Center-align the hint text
                    decoration: InputDecoration(
                      // hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 16,color: textColor),// Removed extra spaces
                      border: InputBorder.none, // Remove outline border
                    ),
                    onChanged: (text) {
                      setState(() {
                        days=text;
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
                    editleave();
                  });
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
