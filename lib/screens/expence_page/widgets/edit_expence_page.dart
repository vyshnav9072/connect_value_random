import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../navigation/bottomnavigation_screen.dart';
import '../../../resources/color.dart';
import '../../../services/expence_service.dart';
import '../../../support/logger.dart';

class editexpance extends StatefulWidget {
   editexpance({super.key,required this.km,required this.id,required this.expance,required this.day,required this.toplace,required this.vechile,required this.fromplace,required this.desription});

   final String km;
   final String id;
   final String expance;
   final String day;
   final String toplace;
   final String vechile;
   final String fromplace;
   final String desription;

  @override
  State<editexpance> createState() => _editexpanceState();
}

class _editexpanceState extends State<editexpance> {



  TextEditingController kmController = TextEditingController();
  TextEditingController expanceController = TextEditingController();
  TextEditingController toplaceController = TextEditingController();
  TextEditingController vechileController = TextEditingController();
  TextEditingController fromplaceController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController desriptionController = TextEditingController();

  late String km;
  late String expance;
  late String toplace;
  late String vechile;
  late String fromplace;
  late String day;
  late String desription;


  var userid;


  @override
  void initState() {
    super.initState();
    km = widget.km;
    expance=widget.expance;
    toplace=widget.toplace;
    vechile=widget.vechile;
    fromplace=widget.fromplace;
    day=widget.day;
    desription=widget.desription;



    kmController.text = km;
    expanceController.text=expance;
    toplaceController.text=toplace;
    vechileController.text=vechile;
    fromplaceController.text=fromplace;
    dayController.text=day;
    desriptionController.text=desription;

  }

  Future<void> editWorkReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print(widget.id);
    var reqData = {
      'km': kmController.text,
      'amount':expanceController.text,
      'vechicle': vechileController.text,
      'from_place': fromplaceController.text,
      'to_place': toplaceController.text,
      'day': dayController.text,
      'description':desriptionController.text,
    };

    try {
      var response = await ExpenceService.ExpenceEdit(reqData, widget.id);
      log.i('successfully editing page. $response');
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
    return Scaffold(

      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Edit Expenses", style: TextStyle(color: bg)),
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
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              padding:EdgeInsets.symmetric(horizontal: 20),
              child:Container(
                padding:EdgeInsets.only(left:12,bottom: 7),
                child: TextFormField(
                  controller: dayController,
                  decoration:InputDecoration(
                    hintText:"Type your vechile",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border:InputBorder.none,
                    fillColor:Colors.white,
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

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Vehicle type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)),
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
                  controller: vechileController,
                  decoration:InputDecoration(
                    hintText:"Type your vechile",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border:InputBorder.none,
                    fillColor:Colors.white,
                  ),
                  onChanged: (text) {
                    setState(() {
                      vechile=text;
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
                              controller: fromplaceController,
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
                              controller: toplaceController,
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
                              controller: kmController,
                              decoration:InputDecoration(
                                hintText:"Kilometeres",
                                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                border:InputBorder.none,
                                fillColor:Colors.white,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  km=text;
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
                               controller: expanceController,
                              decoration:InputDecoration(
                                hintText:"Total Amount",
                                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                border:InputBorder.none,
                                fillColor:Colors.white,
                              ),
                              enabled: false,

                              onChanged: (text) {
                                setState(() {
                                  expance=text;
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


          SizedBox(height: 20,),


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
                  controller: desriptionController,
                  decoration:InputDecoration(
                    hintText:"Description",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border:InputBorder.none,
                    fillColor:Colors.white,
                  ),
                  onChanged: (text) {
                    setState(() {
                      desription=text;
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
                    editWorkReport();
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
