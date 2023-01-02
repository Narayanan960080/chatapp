import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/View/Helper/animation/fadeanimation.dart';
import 'package:expenses/View/HomeView.dart';
import 'package:expenses/View/Helper/StyleData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Util/LocalStorage.dart';



class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();
  bool isLoading = false;
  Future<bool> _willPopBt(){
    if(MediaQuery.of(context).viewInsets.bottom < 0){
      FocusScope.of(context).unfocus();
    }
    return Future.value(false);
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop:()=>_willPopBt(),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: StyleData.background,
            body: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(height: height* 0.06),
                    FadeAnimation(
                        delay: 0.8,
                        isTopToBottom: true,
                        child: Lottie.asset('assets/JSON/analytics.json',height: height* 0.37)),
                    FadeAnimation(
                      delay: 1,
                      isTopToBottom: true,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text("Hey,",style:TextStyle(
                                  color: Colors.white,fontWeight: FontWeight.bold,
                                  fontSize: 30
                                  , shadows: [
                                Shadow(
                                    color: Colors.black38.withOpacity(0.3),
                                    offset: const Offset(3, 6),
                                    blurRadius: 15),
                              ],
                                fontFamily: "Font1"
                              ))
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text("Login Now",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                  fontSize: 25
                                  , shadows: [
                                    Shadow(
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(3, 6),
                                        blurRadius: 15),
                                  ],
                                  fontFamily: "Font1"
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeAnimation(
                      delay: 1.5,
                      isTopToBottom: true,
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  // border: Border(bottom: BorderSide(color: Colors.black12))
                                  ),
                              child: TextFormField(
                                controller: username,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: Colors.white,fontFamily: "Font1",fontSize: 13
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Please enter email id";
                                  }else if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return 'Please enter a valid Email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(color: Colors.white),
                                  focusColor: Colors.white,
                                  filled: true,

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.white60),
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.white,width: 2),
                                  ),
                                  labelText: "Username",
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w700,

                                      fontSize: 15,fontFamily: "Font1"),
                                  prefixIcon: const Icon(
                                    Icons.person_pin,
                                    size: 18,
                                    color: Colors.white,
                                  ),

                                ),
                              )),
                          const SizedBox(height: 10),
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  // border: Border(bottom: BorderSide(color: Colors.black12))
                                  ),
                              child: TextFormField(
                                controller: password,
                                obscureText: true,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Please enter password";
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                    color: Colors.white,fontFamily: "Font1",fontSize: 13
                                ),
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(color: Colors.white),
                                  focusColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.white60),
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.white,width: 2),
                                  ),
                                  labelText: "Password",
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,fontFamily: "Font1"),
                                  prefixIcon: const Icon(
                                    Icons.lock_open_outlined,
                                    size: 18,
                                    color: Colors.white,
                                  ),

                                ),
                              )),
                        ],
                      ),
                    ),
                    // ),
                    const SizedBox(height: 20),
                    FadeAnimation(
                      delay: 1.8,
                      isTopToBottom: false,
                      child: InkWell(
                        onTap: () async {
                          if(_formkey.currentState!.validate() && !isLoading){
                            setState(() => isLoading = true);
                            try {
                              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email:username.text,
                                  password: password.text
                              );
                              if(credential.user != null){
                                print(credential.user!.uid);
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(credential.user!.uid)
                                    .get()
                                    .then((value) {
                                  setState(() => isLoading = false);
                                  LocalStorage.setData(key: "username", value: value['name']);
                                  LocalStorage.setData(key: "token", value: credential.user!.uid);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeView()));

                                });

                              }
                            } on FirebaseAuthException catch (e) {
                              setState(() => isLoading = false);
                              print(e);
                              String? content;
                              if (e.code == 'user-not-found') {
                                content = 'Username or password wrong incorrect';
                                print('No user found for that email.');
                                snackAlert(context,'No user found for that email !',Colors.amberAccent,Icons.error_outline);
                              }else if (e.code == 'wrong-password') {
                                content = 'Username or password incorrect';
                                snackAlert(context,'Username or password incorrect !',Colors.amberAccent,Icons.error_outline);
                              }else{
                                content = 'Username or password wrong incorrect';
                                snackAlert(context,'Username or password wrong incorrect !',Colors.amberAccent,Icons.error_outline);
                              }

                              SnackBar(
                                  backgroundColor: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  content: Row(
                                    children:  [
                                      const Icon(Icons.error_outline,color: Colors.redAccent),
                                      const SizedBox(width: 20),
                                      Text(
                                        content,
                                        style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,),textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ));
                            }
                          }else{
                            snackAlert(context,'Please fill all field !',Colors.amberAccent,Icons.error_outline);
                          }


                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child:  Center(
                              child: isLoading ? const CircularProgressIndicator(strokeWidth: 2,color: Colors.white,) : const Text("LOGIN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Font1",fontSize: 18),),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//alert bar
snackAlert(BuildContext context,content,Color color,icon){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight:Radius.circular(20) ,topLeft: Radius.circular(20))),
        content: Row(
          children:  [
            Icon(icon),
            const SizedBox(width: 20),
            Text(
              content,
              style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w700,),textAlign: TextAlign.center,
            ),
          ],
        )),
  );
}