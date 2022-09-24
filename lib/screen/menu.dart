import 'package:co_voit/screen/consultationTrajet.dart';
import 'package:co_voit/screen/creation_Trajet.dart';
import 'package:co_voit/screen/fristScreen.dart';
import 'package:co_voit/screen/profil_page.dart';
import 'package:co_voit/screen/test_autocomplete.dart';
import 'package:co_voit/services/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'style.dart';
import 'fristScreen.dart';

class main_menu extends StatelessWidget {
  const main_menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationService.initialize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: menuScreen(),
    );
  }
}

class menuScreen extends StatefulWidget {
  const menuScreen({Key? key}) : super(key: key);

  @override
  State<menuScreen> createState() => _menuScreenState();
}

class _menuScreenState extends State<menuScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      print(message.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Menu Principal',
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (() => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profilPage()))),
              icon: Icon(Icons.person_outline)),
          Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                  onPressed: () {
                    showDeconnexion();
                  },
                  icon: Icon(Icons.logout_rounded))),
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => testAutoComplete())),
            icon: Icon(Icons.textsms_outlined),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.green),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => creationTrajet()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: hauteur * 0.4,
                  child: Card(
                      elevation: 10.0,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.control_point_outlined,
                                  color: Colors.amber,
                                  size: 40,
                                ),
                              ),
                              Text("Je crée un trajet",
                                  style: GoogleFonts.pacifico(
                                      color: Colors.amber,
                                      fontSize: 20,
                                      decoration: TextDecoration.underline)),
                            ],
                          ),
                          Lottie.network(
                              "https://assets9.lottiefiles.com/packages/lf20_sqj2duaj/map.json",
                              height: hauteur * 0.25)
                        ],
                      )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => consultationTrajet()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: hauteur * 0.4,
                  child: Card(
                      elevation: 10.0,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.amber,
                                  size: 40,
                                ),
                              ),
                              Text("Je cherche un trajet",
                                  style: GoogleFonts.pacifico(
                                      color: Colors.amber,
                                      fontSize: 20,
                                      decoration: TextDecoration.underline)),
                            ],
                          ),
                          Lottie.network(
                              "https://assets2.lottiefiles.com/private_files/lf30_gd2unfh8.json",
                              height: hauteur * 0.3)
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDeconnexion() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            title: Text(
              'Voulez-vous vous déconnecter ?',
              style: stylePrincipal25,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        side: BorderSide(color: Colors.black)),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login_screen()));
                    },
                    child: Text('OUI'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shadowColor: Colors.black,
                        side: BorderSide(color: Colors.black)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('NON'),
                  )
                ],
              )
            ],
          );
        });
  }
}
