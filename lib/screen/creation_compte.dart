import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_voit/screen/profil_page.dart';
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
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  String? _nom;

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
                          "https://assets6.lottiefiles.com/packages/lf20_dyq0qz89/data.json")),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    //    height: hauteur / 3,
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
                        controller: _nomController,
                        decoration: InputDecoration(
                            label: Text('Nom'),
                            labelStyle:
                                GoogleFonts.pacifico(color: Colors.white),
                            // ignore: prefer_const_constructors
                            prefixIcon: Icon(
                              Icons.person_add_alt,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _prenomController,
                        decoration: InputDecoration(
                            label: Text('Prénom'),
                            labelStyle:
                                GoogleFonts.pacifico(color: Colors.white),
                            // ignore: prefer_const_constructors
                            prefixIcon: Icon(
                              Icons.person_add_alt_1,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30))),
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
                              Icons.email_outlined,
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
                          addname();
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
      newUser.user!.updateDisplayName(_nomController.text);
      print(newUser);
    } catch (erreur) {
      print(erreur.toString());
    }
  }

  void addname() async {
    try {
      FirebaseFirestore.instance.collection(_nomController.text).add({
        'nom': _nomController.text,
        'prenom': _prenomController.text
      }).then((value) => print(value));
    } catch (erreur) {
      print(erreur.toString());
    }
    setState(() {
      _nom = _nomController.text;
    });
  }
}
