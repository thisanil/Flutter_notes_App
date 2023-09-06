import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'common/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData(

      ),
      home:AnimatedSplashScreen(
        splash:'assets/login.jpg',


        splashIconSize: double.maxFinite,
        centered: true,
        duration: 2000,
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.slideTransition,
      )

    );

  }
}

