import 'dart:async';

import 'package:expenses/View/Helper/StyleData.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper/animation/fadeanimation.dart';
import 'HomeView.dart';
import 'LoginView.dart';






class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  route() async {
    super.initState();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Timer(
        const Duration(seconds: 2),
            () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) {
            if(token != null){
              return  const HomeView();

            }else{
              return const LoginView();
            }
            // return token == null ? const LoginPage() : type == "student" ? const HomePage(): const HomeAdmin();
          }));
        });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    route();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: StyleData.background,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child:
          FadeAnimation(
              delay: 0.5,
              isTopToBottom: true,
              child: Lottie.asset('assets/splash_logo.json',height: height* 0.2))),
          SizedBox(height: height * 0.02,),
          FadeAnimation(
            delay: 1.1,
            isTopToBottom: false,
            child: Text("Welcome,",style:TextStyle(
                color: Colors.white,fontWeight: FontWeight.w500,
                fontSize: 24
                , shadows: [
              Shadow(
                  color: Colors.black38.withOpacity(0.3),
                  offset: const Offset(2, 4),
                  blurRadius: 7),
            ],
                fontFamily: "Font1"
            )),
          )
        ],
      ) ,
    );
  }
}