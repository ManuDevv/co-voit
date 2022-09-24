import 'dart:ffi';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:co_voit/screen/creation_Trajet.dart';
import 'package:co_voit/screen/fristScreen.dart';
import 'package:co_voit/screen/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.notification!.title.toString());
  print('test notification');
  
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseAuth.instance.authStateChanges().listen((User? utilisateur) {
    if (utilisateur == null) {
      print('Utilisateur non connecté');
      runApp(MyApp());
    } else {
      print('Utilisateur connecté: ' + utilisateur.email!);
      runApp(main_menu());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: splashScreen());
  }
}

class splashScreen extends StatelessWidget {
  splashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(
      duration: 4500,
      centered: true,
      splash: Text(
        'Co-voit',
        style: GoogleFonts.pacifico(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 50,
            decorationStyle: TextDecorationStyle.solid),
      ),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: Colors.green,
      nextScreen: loginScreen(),
      pageTransitionType: PageTransitionType.leftToRightWithFade,
    );
  }
}
