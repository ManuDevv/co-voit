import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class creation_compte extends StatefulWidget {
  creation_compte({Key? key}) : super(key: key);

  @override
  State<creation_compte> createState() => _creation_compteState();
}

class _creation_compteState extends State<creation_compte> {
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
                          "https://assets6.lottiefiles.com/packages/lf20_dyq0qz89/data.json")
                    
                      ),
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
                            label: Text('Votre Email'),
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
                            prefixIcon: Icon(
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
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addUser();
                        },
                        // ignore: sort_child_properties_last
                        child: Text(
                          'Créer un compte ',
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
                    ]),
                  ),
                ],
              ),
            ))));
  }

  void addUser() async {
    print(_emailController.text);
    print(_passwordController.text);
    try {
      UserCredential newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
    } catch (erreur) {
      print(erreur.toString());
    }
  }
}
