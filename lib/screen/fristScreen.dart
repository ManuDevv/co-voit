import 'package:animated_login/animated_login.dart';
import 'package:co_voit/screen/creation_compte.dart';
import 'package:co_voit/screen/menu.dart';
import 'package:co_voit/screen/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login_screen extends StatelessWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginScreen(),
    );
  }
}

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);
  @override
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  double test = 200;
  double _opacity = 0;
  double _offset = -10;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 

  @override
  Widget build(BuildContext context) {
    var largeur = MediaQuery.of(context).size.width;
    var hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(color: Colors.green),
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Lottie.network(
                          "https://assets10.lottiefiles.com/packages/lf20_yqzlxe4m.json")),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(10),
                    height: hauteur / 2,
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
                        controller: _emailController,
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
                        controller: _passwordController,
                        decoration: InputDecoration(
                            label: Text('Mot de passe'),
                            labelStyle:
                                GoogleFonts.pacifico(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.lock_open,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signIn();
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
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => creation_compte()));
                          },
                          child: Text(
                            'Créer un compte',
                            style: stylePrincipalSurligne,
                          ))
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

  void signIn() {
    print(_emailController);
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        print(value);
      });
    } catch (erreur) {
      print(erreur.toString());
    }
  }
}
