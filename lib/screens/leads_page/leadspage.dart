import 'package:flutter/material.dart';
import 'package:seclobstaff/screens/leads_page/widgets/add_leads_page.dart';
import 'package:seclobstaff/screens/leads_page/widgets/lead_innerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../../common_widgets/search.dart';
import '../../resources/color.dart';
import '../../services/leads_service.dart';
import '../../support/logger.dart';
import 'package:flutter_web_pagination/flutter_web_pagination.dart';
import 'package:shimmer/shimmer.dart';

class leadpage extends StatefulWidget {
  const leadpage({super.key});

  @override
  State<leadpage> createState() => _leadpageState();
}

class _leadpageState extends State<leadpage> {

  String dropdownValue = 'Pending';

  List <String> spinnerItems = [
    'Pending',
    'Complted',
  ];

  var userid;
  var leadlist;
  bool _isLoading = true;
  var status = 'New';
  var hrid;


  Future leadlists(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    hrid = prefs.getString('hr_id');
    print(userid);
    print(hrid);
    var reqData = {
      'tc_id': userid,
      'hr_id':hrid,
      'status': status
    };
    var response = await LeadService.LeadList(reqData);
    log.i('Completed lead list page');
    setState(() {
      leadlist = response;
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
    leadlists(status)
      ],
    );
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("leads", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: false, // Display the back button
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  searchpage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),

      body: _isLoading
          ? Shimmer.fromColors(
        baseColor: greybg, // The color of the shimmer effect when not active
        highlightColor: textgray, // The color of the shimmer highlight when not active
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Column(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: (){

                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title:  Text('Select Data'),

                          content: Container(
                            height: 340,
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      status = 'Pending';
                                      leadlists(status);
                                      Navigator.pop(context);
                                      print(status);
                                    });
                                  },
                                  child: Text(
                                      'Pending'),
                                ),

                                Divider(),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: (){
                                    status = 'New';
                                    leadlists(status);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                      'New'),
                                ),
                                Divider(),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: (){
                                    status = 'Following';
                                    leadlists(status);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                      'Following'),
                                ),
                                Divider(),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: (){
                                    status = 'Not Responding';
                                    leadlists(status);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                      'Not Responding'),
                                ),
                                Divider(),
                                SizedBox(height: 10,),

                                GestureDetector(
                                  onTap: (){
                                    status = 'Cancelled';
                                    leadlists(status);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                      'Cancelled'),
                                ),
                                Divider(),
                                SizedBox(height: 10,),

                                GestureDetector(
                                  onTap: (){
                                    status = 'Completed';
                                    leadlists(status);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                      'Completed'),
                                ),
                                Divider(),
                                SizedBox(height: 10,),

                                GestureDetector(
                                  onTap: (){
                                    status = 'Deleted';
                                    leadlists(status);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                      'Deleted'),
                                ),
                                Divider(),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                          actions: <Widget>[

                            // TextButton(
                            //   onPressed: () {
                            //
                            //     Navigator.pop(context);
                            //   },
                            //   child:  Text(
                            //     'Submit',
                            //     style: TextStyle(
                            //         color: greenpermanat),
                            //   ),
                            // ),
                          ],
                        ),
                  );
                },

                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: bg,

                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      Icons.filter_list_outlined,
                      color: Colors.black,
                      size: 24.0,
                      semanticLabel: 'filletr',
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 5,),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: leadlist['users'].length,
                itemBuilder: (BuildContext context, int index) {
                  return leadlisting(
                    name: leadlist['users'][index]['name'],
                    mobile:leadlist['users'][index]['mobile'],
                    date:leadlist['users'][index]['created_at'],
                    status:leadlist['users'][index]['status'],
                    amount:leadlist['users'][index]['amount'],
                    id:leadlist['users'][index]['id'].toString(),
                    companyname:leadlist['users'][index]['company'],

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
            MaterialPageRoute(builder: (context) =>  addleads(
            )),
          );
        },
        child: const Icon(Icons.add,color: bg,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


    );
  }
}

class leadlisting extends StatelessWidget {
  const leadlisting({
    super.key,
    required this.name,
    required this.mobile,
    required this.date,
    required this.status,
    required this.amount,
    required this.id,
    required this.companyname

  });

  final String name;
  final String mobile;
  final String date;
  final String status;
  final String amount;
  final String id;
  final String companyname;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => leadinner(
                id: id,
              )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0), // Add bottom spacing
        child: Container(
          height: 110,
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



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: bottomtabbg),),

                    Container(
                      height: 18,
                      width: 62,
                      decoration: BoxDecoration(
                        color: g1,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(child: Text(status,style: TextStyle(fontSize: 8,color: bg),)),
                    )
                  ],
                ),

                SizedBox(height:5),
                Text(companyname,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bottomtabbg),),
                SizedBox(height:5),

                Text(date,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bggreay),),
                SizedBox(height:5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(mobile,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bggreay)),

                    InkWell(
                      onTap: (){
                        FlutterPhoneDirectCaller.callNumber(mobile);
                      },
                      child: Container(
                        height: 25,
                        width: 90,
                        decoration: BoxDecoration(
                          color: gradient1,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(child: Text("clicktocall",style: TextStyle(fontSize: 8,color: bg),)),
                      ),
                    )
                  ],
                ),

                Text(amount,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bggreay)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
