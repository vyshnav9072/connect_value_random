import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../resources/color.dart';
import '../../../../services/workreport_service.dart';
import '../../../../support/logger.dart';
import 'add_workreport.dart';
import 'edit_workreport.dart';

class workreport extends StatefulWidget {
  const workreport({super.key});

  @override
  State<workreport> createState() => _workreportState();
}

class _workreportState extends State<workreport> {


  bool _isLoading = true;
  var userid;
  var workreportlist;

  Future workreportlists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print(userid);
    var reqData = {
      'user_id': userid,
    };
    var response = await WorkreportService.WorkreportList(reqData);
    log.i('Completed work report list page');
    setState(() {
      workreportlist = response;
      print(response);
      print('................USER IDDDDDD$userid');
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
      [workreportlists()],
    );
    _isLoading = false;
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Work Report", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: true, // Display the back button
        iconTheme: IconThemeData(color: Colors.white), // Change the back button color to white
      ),

      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          :  Column(
        children: [

          SizedBox(height: 20,),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount:workreportlist['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0), // Add bottom spacing
                    child: Container(
                      height: 80,
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
                                Text(workreportlist['data'][index]['type'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: bottomtabbg),),

                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditWorkReport(
                                        description: workreportlist['data'][index]['message'],
                                        id:workreportlist['data'][index]['id'].toString(),


                                      )),
                                    );
                                  },
                                  child: Container(
                                    height: 18,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: orange,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Center(child: Text("Edit",style: TextStyle(fontSize: 8,color: bg),)),
                                  ),
                                )
                              ],
                            ),


                            Text(workreportlist['data'][index]['day'],style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bottomtabbg),),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                workreportlist['data'][index]['message'],
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: bottomtabbg),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
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
            MaterialPageRoute(builder: (context) =>  addworkreport()),
          );
        },
        child: const Icon(Icons.add,color: bg,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


    );
  }
}
