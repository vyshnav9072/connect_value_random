import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../navigation/bottomnavigation_screen.dart';
import '../../../resources/color.dart';
import '../../../services/expence_service.dart';
import '../../../support/logger.dart';

class addexpence extends StatefulWidget {
  const addexpence({super.key});

  @override
  State<addexpence> createState() => _addexpenceState();
}

class _addexpenceState extends State<addexpence> {

  Future getshowDatePicker() async {
    var selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    return selected;
  }



  var userid;


  String? date;
  String? vechiletype;
  String? fromplace;
  String? toplace;
  String? kilometer;
  String? totalamount;
  String? decription;



  String selecteddate = "Select Date";


  Future createxpence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');

    var reqData = {
      'user_id': userid,
      'day': date,
      'vechicle':vechiletype,
      'from_place':fromplace,
      'to_place':toplace,
      'km':kilometer,
      'amount':totalamount,
      "type":'TelleCaller',
      'description':decription,
    };
    print(reqData);
    var response = await ExpenceService.CreateExpence(reqData);
    log.i('expence create service. $response');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomTabsScreen()),
    );

  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Add Expenses", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: true, // Display the back button
        iconTheme: IconThemeData(color: Colors.white), // Change the back button color to white
      ),

      body: Column(
        children: [

          SizedBox(height: 20,),



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


          SizedBox(height: 20,),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Vechicle type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
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
                    hintText:"Type your vechile",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border:InputBorder.none,
                    fillColor:Colors.white,
                  ),
                  onChanged: (text) {
                    setState(() {
                      vechiletype=text;

                    });
                  },
                ),
              ),
            ),
          ),


          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'From',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ),
                        subtitle: Container(
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
                                hintText:"from",
                                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                border:InputBorder.none,
                                fillColor:Colors.white,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  fromplace=text;

                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'To',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ),
                        subtitle: Container(
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
                                hintText:"To",
                                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                border:InputBorder.none,
                                fillColor:Colors.white,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  toplace=text;

                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Kilometeres',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ),
                        subtitle: Container(
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
                                hintText:"Kilometeres",
                                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                border:InputBorder.none,
                                fillColor:Colors.white,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  kilometer=text;

                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Total amount',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ),
                        subtitle: Container(
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
                                hintText:"Total Amount",
                                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                border:InputBorder.none,
                                fillColor:Colors.white,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  totalamount=text;

                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Description",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  color: graybg,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              padding:EdgeInsets.symmetric(horizontal: 20),
              child:Container(
                padding:EdgeInsets.only(left:12,bottom: 7),
                child: TextFormField(
                  decoration:InputDecoration(
                    hintText:"Description",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border:InputBorder.none,
                    fillColor:Colors.white,
                  ),
                  onChanged: (text) {
                    setState(() {
                      decription=text;
                    });
                  },
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
                    createxpence();
                  });

                  // _profileEditing();
                },
              ),
            ),
          ),

        ],
      ),

    );
  }
}
