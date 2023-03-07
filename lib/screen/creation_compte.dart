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
  final List equipe = ["1", "2", "3", "4", "5"];
  String _first_item = '1';
  final _key = GlobalKey<FormState>();

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
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                      Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nomController,
                                validator: ((value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Le champs est vide';
                                  }
                                  return null;
                                }),
                                decoration: InputDecoration(
                                    label: Text('Nom'),
                                    labelStyle: GoogleFonts.pacifico(
                                        color: Colors.white),
                                    // ignore: prefer_const_constructors
                                    prefixIcon: Icon(
                                      Icons.person_add_alt,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _prenomController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ce champ est vide';
                                  }
                                },
                                decoration: InputDecoration(
                                    label: Text('Prénom'),
                                    labelStyle: GoogleFonts.pacifico(
                                        color: Colors.white),
                                    // ignore: prefer_const_constructors
                                    prefixIcon: Icon(
                                      Icons.person_add_alt_1,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Equipe',
                                        style: GoogleFonts.pacifico(
                                            color: Colors.white, fontSize: 20)),
                                    DropdownButton(
                                        items: [
                                          DropdownMenuItem(
                                              value: "1",
                                              child: Text('1',
                                                  style: GoogleFonts.pacifico(
                                                    color: Colors.black,
                                                  ))),
                                          DropdownMenuItem(
                                              value: "2",
                                              child: Text('2',
                                                  style: GoogleFonts.pacifico(
                                                    color: Colors.black,
                                                  ))),
                                          DropdownMenuItem(
                                              value: "3",
                                              child: Text('3',
                                                  style: GoogleFonts.pacifico(
                                                    color: Colors.black,
                                                  ))),
                                          DropdownMenuItem(
                                              value: "4",
                                              child: Text('4',
                                                  style: GoogleFonts.pacifico(
                                                    color: Colors.black,
                                                  ))),
                                          DropdownMenuItem(
                                              value: "5",
                                              child: Text('5',
                                                  style: GoogleFonts.pacifico(
                                                    color: Colors.black,
                                                  ))),
                                        ],
                                        value: _first_item,
                                        onChanged: liste_deroulante),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _emailController,
                                //validator: ,
                                decoration: InputDecoration(
                                    label: Text('Votre Email'),
                                    labelStyle: GoogleFonts.pacifico(
                                        color: Colors.white),
                                    // ignore: prefer_const_constructors
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return '6 caractères minimun';
                                  }
                                },
                                decoration: InputDecoration(
                                    label: Text('Mot de passe'),
                                    labelStyle: GoogleFonts.pacifico(
                                        color: Colors.white),
                                    prefixIcon: Icon(
                                      Icons.lock_open,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  addUser();
                                  if (_key.currentState!.validate()) ;
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
                                      color: Colors.white.withOpacity(0.5),
                                      width: 3),
                                ),
                              ),
                            ],
                          ))
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
      final User? user = FirebaseAuth.instance.currentUser;
      final _uid = user!.uid;
      FirebaseFirestore.instance.collection('user').doc(_uid).set({
        'firstName': _nomController.text.trim(),
        'name': _prenomController.text.trim(),
        'equipe': _first_item
      });

      print(newUser);
    } catch (erreur) {
      print(erreur.toString());
    }
  }

  void liste_deroulante(String? _select_value) {
    if (_select_value is String) {
      setState(() {
        _first_item = _select_value;
      });
    }
  }
}
