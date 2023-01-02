import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/LocalStorage.dart';


class ChartView extends StatefulWidget {
  const ChartView({Key? key}) : super(key: key);



  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  final messageInsert = TextEditingController();
  String? token;
  String username = "";
  fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "";
      token = prefs.getString('token') ?? "";
    });


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<bool> backBt(){
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () =>backBt(),
      child: SafeArea(
        child: GestureDetector(
          onTap:()=>FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,

            appBar: AppBar(
              // backgroundColor: const Color(0xffd5d5ce),
              backgroundColor: Colors.white,
              leading:
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios,size: 18,color: Colors.black54,)),
              title: Text(username, style:TextStyle(color:Colors.black54),),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 17,
                    backgroundImage: AssetImage('assets/Profile Demo.jpg'),
                  ),
                ),
              ],

            ),
            body: Container(

              decoration: const BoxDecoration(

                image: DecorationImage(
                  image: AssetImage("assets/chatscreen.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Text("Today, ${DateFormat("Hm").format(DateTime.now())}", style: const TextStyle(
                        fontSize: 17,color: Colors.black38
                    ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("chatbox").orderBy('created', descending: true).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return Flexible(
                            child: ListView.builder(
                                reverse: true,
                                itemCount: 0,
                                itemBuilder: (context, index) {

                                  return SizedBox();
                                }

                            )
                        );
                      }
                      print(snapshot.data!.docs.length);

                      if ( snapshot.data!.docs.isEmpty){
                        return Flexible(
                            child: ListView.builder(
                                reverse: true,
                                itemCount: 0,
                                itemBuilder: (context, index) {

                                  return SizedBox();
                                }

                            )
                        );
                      }

                      return  Flexible(
                          child: ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var data =  snapshot.data!.docs;
                                return chat(data[index]["message"].toString(),token == data[index]["userid"] ? 0 : 1 ,data);
                              }

                          )
                      );
                    },),

                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 5.0,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 36,
                    child: Row(
                      children: [
                        SizedBox(width: width * 0.04,),
                        Container(
                          height: 35,
                          width: width * 0.8,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                18)),
                            color:   Color.fromRGBO(67, 106, 101, 1.0),
                          ),
                          padding: const EdgeInsets.only(left: 10,right: 8),
                          child: TextFormField(
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (value){
                              setData();
                            },
                            cursorColor: Colors.white,
                            controller: messageInsert,
                            decoration: const InputDecoration(
                              hintText: "Message",
                              hintStyle: TextStyle(
                                  color: Colors.white70
                              ),
                              contentPadding:EdgeInsets.only(left: 4,bottom: 13) ,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),

                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                            onChanged: (value) {

                            },
                          ),
                        ),
                        SizedBox(width: width * 0.01,),
                        CircleAvatar(
                          backgroundColor: const Color.fromRGBO(67, 106, 101, 1.0),
                          child: Center(
                            child: IconButton(

                                icon: const Icon(

                                  Icons.send,
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                                onPressed: () {

                                  setData();


                                }),
                          ),
                        ),
                        SizedBox(width: width * 0.01,),
                      ],
                    ),
                  ),
                  // ListTile(
                  //
                  //   title: Container(
                  //     height: 35,
                  //     decoration: const BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(
                  //           18)),
                  //       color:   Color.fromRGBO(67, 106, 101, 1.0),
                  //     ),
                  //     padding: const EdgeInsets.only(left: 10,right: 8),
                  //     child: TextFormField(
                  //       textInputAction: TextInputAction.go,
                  //       onFieldSubmitted: (value){
                  //         setData();
                  //       },
                  //       cursorColor: Colors.white,
                  //       controller: messageInsert,
                  //       decoration: const InputDecoration(
                  //         hintText: "Message",
                  //         hintStyle: TextStyle(
                  //             color: Colors.white70
                  //         ),
                  //         contentPadding:EdgeInsets.only(left: 4,bottom: 11) ,
                  //         border: InputBorder.none,
                  //         focusedBorder: InputBorder.none,
                  //         enabledBorder: InputBorder.none,
                  //         errorBorder: InputBorder.none,
                  //         disabledBorder: InputBorder.none,
                  //       ),
                  //
                  //       style: const TextStyle(
                  //           fontSize: 16,
                  //           color: Colors.white
                  //       ),
                  //       onChanged: (value) {
                  //
                  //       },
                  //     ),
                  //   ),
                  //
                  //   trailing: CircleAvatar(
                  //     backgroundColor: const Color.fromRGBO(67, 106, 101, 1.0),
                  //     child: Center(
                  //       child: IconButton(
                  //
                  //           icon: const Icon(
                  //
                  //             Icons.send,
                  //             size: 20.0,
                  //             color: Colors.white,
                  //           ),
                  //           onPressed: () {
                  //
                  //            setData();
                  //
                  //
                  //           }),
                  //     ),
                  //   ),
                  //
                  // ),

                  const SizedBox(
                    height: 15.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  setData(){

    if(messageInsert.text.isNotEmpty){

      Map<String,dynamic> params = {
        "message":messageInsert.text,
        "type":"0",
        "userid":token,
        "created":Timestamp.now()
      };

      FirebaseFirestore.instance.collection("chatbox").add(params).then((v){

        print('Done');

      }).catchError((onError){
        print(onError);

      });
      messageInsert.clear();
    }

  }



  Widget chat(String message, int data,List dataList) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),

      child: Row(
        mainAxisAlignment: data == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [

          // data == 1 ? SizedBox(
          //   height: 50,
          //   width: 60,
          //   child: CircleAvatar(
          //     backgroundColor: data == 1 ? Colors.white : Colors.blue,
          //     backgroundImage: const AssetImage("assets/robot1.png"),
          //   ),
          // ) : Container(),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Bubble(
                margin: const BubbleEdges.only(top: 10),
                nip: data == 0 ? BubbleNip.rightTop : BubbleNip.leftTop,
                radius: const Radius.circular(15.0),
                color: data == 1 ?  Colors.grey[500] : const Color.fromRGBO(67, 106, 101, 1.0),
                elevation: 0.0,

                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                            constraints: const BoxConstraints( maxWidth: 200),
                            child: Text(
                              message,
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                )),
          ),


          // data == 0 ? const SizedBox(
          //   height: 60,
          //   width: 60,
          //   child: CircleAvatar(
          //     backgroundImage: AssetImage("assets/beard.png"),
          //   ),
          // ) : Container(),

        ],
      ),
    );
  }
}
