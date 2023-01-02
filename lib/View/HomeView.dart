import 'package:expenses/View/MovieLis.dart';
import 'package:flutter/material.dart';

import '../Util/LocalStorage.dart';
import 'ChatScreenView.dart';
import 'Helper/StyleData.dart';




class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<bool> backBt(){
    return Future.value(false);
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () =>backBt(),
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: 200,
              leading:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Text("Team App",style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w600),),
                  ),
                ],
              ) ,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      LocalStorage.logOut(context);
                    },
                    child: const Icon(Icons.logout,color: Colors.black54,),
                  ),
                )
              ],
            ),
            body:SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.03,),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:1,
                          itemBuilder: (BuildContext context, int index){

                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChartView()));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                      child: ListTile(
                                        leading: Container(
                                          height: height/14,
                                          width: height/14,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle
                                          ),
                                          child: ClipOval(
                                              child:Image.asset(
                                                'assets/Profile Demo.jpg',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                          )
                                        ),
                                        title:const Text("Charan",style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w700),),
                                        trailing: const CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.redAccent,
                                          child: Text("3",style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: width * 0.9,
                                      child: const Divider(thickness: 1,)),
                                ],
                              ),
                            );
                          }
                      )
                    ],
                  ),
                ],
              ),
            ) ,
            floatingActionButton: FloatingActionButton(
              backgroundColor: StyleData.background,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const MovieList()));
              },
              child: const Icon(Icons.arrow_forward,color: Colors.white,),
            ),
          )
      ),
    );
  }
}
