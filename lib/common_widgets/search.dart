import 'package:flutter/material.dart';

import '../resources/color.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bottomtabbg,
        title: Text("Search Page", style: TextStyle(color: bg)),
        centerTitle: true,
        automaticallyImplyLeading: true, // Display the back button
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),


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
                padding:EdgeInsets.only(left:5,bottom: 7),
                child: TextFormField(
                  decoration:InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Icon(Icons.search, color: Colors.grey,size: 20,),
                    ),
                    hintText:"Enter contact number",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border:InputBorder.none,
                    fillColor:Colors.white,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                // onTap: (){
                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const leadinner()));
                // },
                child: ListView.builder(
                  itemCount: 4,
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
                                  Text("Bike",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: bottomtabbg),),

                                  Container(
                                    height: 18,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: g1,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Center(child: Text("Completed",style: TextStyle(fontSize: 8,color: bg),)),
                                  )
                                ],
                              ),


                              Text("10.09.2022",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bggreay),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("9074343614",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: bggreay)),

                                  Container(
                                    height: 25,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: gradient1,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Center(child: Text("Click to call",style: TextStyle(fontSize: 8,color: bg),)),
                                  )
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
          ),
        ],
      ),
    );
  }
}
