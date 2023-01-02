import 'dart:async';
import 'package:expenses/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'View/SplashView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
      const MyApp()
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SourceSans',
      ),
      home: const SplashView(),
    );
  }
}



