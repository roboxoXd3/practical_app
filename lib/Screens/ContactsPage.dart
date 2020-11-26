import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:practical_app/Services/CropManager.dart';


import '../Model/User.dart';
import 'UserSearch.dart';
class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  CropManager manager = CropManager();
  String number = "234232323";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("User"),
          centerTitle: true,

        ),
        body: StreamBuilder(
            stream: manager.userListView,
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                List<User> expertList = snapshot.data;
                return Column(

                  children: [

                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showSearch(
                                context: context, delegate: UserSearch());

                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Search"),
//                                      Icon(Icons.search),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(

                          scrollDirection: Axis.vertical,
                          itemCount: expertList.length,
                          itemBuilder: (BuildContext context, int index) {
                            User expert = expertList[index];
                            return GestureDetector(
                              onTap: () {

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: null,

                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    child: Container(
                                      decoration: BoxDecoration(
//                                      color: Colors.red,
                                        borderRadius: BorderRadius.circular(30)
                                      ),

                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(

                                        children: <Widget>[

                                          Container(
                                            padding: EdgeInsets.only(right: 30),
                                            decoration:
                                            BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                                boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[300],

                                              ),

                                            ]),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  expert.name..substring(0,10).toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontFamily: 'Varela',
                                                      fontSize: 20,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(

                                                      expert.email.toString()
                                                          ,
                                                  style: TextStyle(
                                                    fontFamily: 'Varela',
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),


                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Container(
                                                    child: Text(
                                                      number,
                                                      style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 14,
                                                        fontStyle:
                                                        FontStyle.normal,
                                                      ),
                                                    ),
                                                    alignment:
                                                    Alignment.bottomRight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            left: 5,
                                            top: 5,
                                            bottom: 5,
                                            child:Container(

                                              decoration: new BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white10,
                                                    )
                                                  ]),
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingBouncingGrid.square(
                            backgroundColor: Colors.green,
                            size: 80,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Fetching Data, thanks for your patience.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                fontFamily: 'Varela',
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
