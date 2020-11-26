import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:practical_app/Model/User.dart';
import 'package:practical_app/Services/CropManager.dart';



class UserSearch extends SearchDelegate{

  CropManager manager = CropManager();
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if(query.length<3)
      {
        return Center(child: Text("$query + must be great than 3"),);
      }
    else if(query.length>3){
      return StreamBuilder(
          stream: manager.filtereduserListView(query: query),
          builder:
              (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              List<User> expertList = snapshot.data;
              return Container(
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
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
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

                                        expert.email.toString()
                                        ,
                                        style: TextStyle(
                                          fontFamily: 'Varela',
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        expert.name.toString()
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
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 8.0),
                                        child: Container(
                                          child: Text(
                                            expert.phone.toString(),
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
//                                            height: 30,
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
                    );
                  },
                ),
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
                          "Fetching Users, thanks for your patience.",
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
          });
    }
    else{
      return Center(child: Text("No search found of this name"),);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }

}