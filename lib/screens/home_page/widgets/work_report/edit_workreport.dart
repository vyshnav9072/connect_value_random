import 'package:flutter/material.dart';
import 'package:seclobstaff/resources/color.dart';
import '../../../../navigation/bottomnavigation_screen.dart';
import '../../../../services/workreport_service.dart';
import '../../../../support/logger.dart';

class EditWorkReport extends StatefulWidget {
  final String description;
  final String id;

  EditWorkReport({required this.description, required this.id});

  @override
  _EditWorkReportState createState() => _EditWorkReportState();
}

class _EditWorkReportState extends State<EditWorkReport> {
  TextEditingController descriptionController = TextEditingController();
  late String description;

  @override
  void initState() {
    super.initState();
    description = widget.description;
    descriptionController.text = description;
  }

  Future<void> editWorkReport() async {
    var reqData = {
      'id': widget.id,
      'message': descriptionController.text,
    };
    try {
      var response = await WorkreportService.WorkreportEdit(reqData, widget.id);
      log.i('Workreport editing page. $response');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomTabsScreen()),
      );
    } catch (error) {
      print('Error editing work report: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text(
          "Edit Work Report",
          style: TextStyle(color: bg),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ),
          ),
          SizedBox(height: 10),
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
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 16, color: textColor),
                      border: InputBorder.none,
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
          SizedBox(height: 20),
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
                  editWorkReport();
                },
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

