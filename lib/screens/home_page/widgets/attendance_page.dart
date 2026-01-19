import 'package:flutter/material.dart';

import '../../../resources/color.dart';

class attendancepage extends StatefulWidget {
  const attendancepage({super.key});

  @override
  State<attendancepage> createState() => _attendancepageState();
}

class _attendancepageState extends State<attendancepage> {

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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Attendance", style: TextStyle(color: bg)),
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

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("start time",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
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
                    hintText:"10:00 AM",
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
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("End time",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
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
                    hintText:"10:00 AM",
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
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Location",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
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
                    hintText:"location",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border:InputBorder.none,
                    fillColor:Colors.white,
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


                  });
                  // _profileEditing();
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
