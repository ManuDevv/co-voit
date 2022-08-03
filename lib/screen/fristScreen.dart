import 'package:animated_login/animated_login.dart';
import 'package:co_voit/screen/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class fristScreen extends StatefulWidget {
  fristScreen({Key? key}) : super(key: key);
  @override
  @override
  State<fristScreen> createState() => _fristScreenState();
}

class _fristScreenState extends State<fristScreen> {
  double test = 200;
  double _opacity = 0;
  double _offset = -10;

  @override
  void initState() {
    testOpacity(dynamic);
    testSlide();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var largeur = MediaQuery.of(context).size.width;
    var hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Color(0xff2CBF9C),
                //     Color(0xff008D53),
                //   ],
                // )
                color: Colors.green),
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AnimatedSlide(
                      offset: Offset(_offset, 0),
                      duration: Duration(seconds: 5),
                      curve: Curves.bounceOut,
                      child: Image.asset('asset/voiture2.png', scale: 0.5),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(10),
                    height: hauteur / 2.5,
                    width: largeur * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(children: [
                      Text(
                        'Co-voit',
                        style: GoogleFonts.pacifico(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            decorationStyle: TextDecorationStyle.solid),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            label: Text('Email'),
                            labelStyle:
                                GoogleFonts.pacifico(color: Colors.white),
                            // ignore: prefer_const_constructors
                            prefixIcon: Icon(
                              Icons.people,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            label: Text('Mot de passe'),
                            labelStyle:
                                GoogleFonts.pacifico(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.lock_open,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30)),
                                focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30)) ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => menuScreen()));
                        },
                        // ignore: sort_child_properties_last
                        child: Text(
                          'Conexion',
                          style: GoogleFonts.pacifico(
                              color: Colors.white,
                              fontSize: 30,
                              letterSpacing: 1.5),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0.5),
                          side: BorderSide(
                              color: Colors.white.withOpacity(0.5), width: 3),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ))));
  }

  testOpacity(dynamic) {
    return Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  testSlide() {
    return Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _offset = 0;
      });
    });
  }
}
