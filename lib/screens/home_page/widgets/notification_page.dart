import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/color.dart';
import '../../../services/notification_servie.dart';
import '../../../support/logger.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  String dropdownValue = 'Pending';

  List<String> spinnerItems = [
    'Pending',
    'Complted',
  ];

  var userid;
  var notificatiolist;
  bool _isLoading = true;

  Future notificationlists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    print(userid);
    var reqData = {
      'to_user_id': userid,
    };
    var response = await NotificationService.Notification(reqData);
    log.i('Completed notification list page');
    setState(() {
      notificatiolist = response;
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
      [notificationlists()],
    );
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Notification", style: TextStyle(color: bg)),
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
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: notificatiolist['data'].isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 150),
                            child: Center(
                                child: Image.asset('assets/image/noData.jpg')),
                          )
                        : ListView.builder(
                            itemCount: notificatiolist['data'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                // Add bottom spacing
                                child: Container(
                                  height: 150,
                                  width: 320,
                                  decoration: BoxDecoration(
                                      color: expencepagebg,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notificatiolist['data'][index]
                                              ['type'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: bottomtabbg),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              notificatiolist['data'][index]['date'],
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  color: bggreay),
                                            ),
                                            Container(
                                              height: 18,
                                              width: 62,
                                              decoration: BoxDecoration(
                                                color: r1,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                              ),
                                              child: Center(
                                                child: DropdownButton<String>(
                                                  alignment: Alignment.center,
                                                  dropdownColor: bggreay,
                                                  value: dropdownValue,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: bg,
                                                  ),
                                                  iconSize: 15,
                                                  elevation: 10,
                                                  style: TextStyle(
                                                      color: bg, fontSize: 12),
                                                  underline: Container(
                                                    height: 2,
                                                    color: Colors.transparent,
                                                  ),
                                                  onChanged: (String? data) {
                                                    // Change the parameter type to String?
                                                    setState(() {
                                                      dropdownValue = data ??
                                                          ''; // Use a default value in case data is null
                                                    });
                                                  },
                                                  items: spinnerItems.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                          fontSize: 8,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: 250,
                                                height: 50,
                                                child: Text(
                                                    notificatiolist['data'][index]['message'],
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: bggreay,
                                                    ))),
                                            Container(
                                              height: 18,
                                              width: 62,
                                              decoration: BoxDecoration(
                                                color: orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                              ),
                                              child: Center(
                                                child: DropdownButton<String>(
                                                  dropdownColor: bggreay,
                                                  value: dropdownValue,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: bg,
                                                  ),
                                                  iconSize: 15,
                                                  elevation: 10,
                                                  style: TextStyle(
                                                      color: bg, fontSize: 12),
                                                  underline: Container(
                                                    height: 2,
                                                    color: Colors.transparent,
                                                  ),
                                                  onChanged: (String? data) {
                                                    // Change the parameter type to String?
                                                    setState(() {
                                                      dropdownValue = data ??
                                                          ''; // Use a default value in case data is null
                                                    });
                                                  },
                                                  items: spinnerItems.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                          fontSize: 8,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
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
    );
  }
}
