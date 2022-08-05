import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class creationTrajet extends StatefulWidget {
  creationTrajet({Key? key}) : super(key: key);

  @override
  State<creationTrajet> createState() => _creationTrajetState();
}

class _creationTrajetState extends State<creationTrajet> {
  int passager = 2;
  final laRefdelaBDD = FirebaseFirestore.instance;
  TextEditingController _depart = TextEditingController();
  TextEditingController _arrivee = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    var largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Je crée un trajet',
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 5))
              ]),
          width: largeur * 0.9,
          height: hauteur * 0.5,
          child: Column(
            children: [
               Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: TextField(
                  controller: _depart,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_searching_outlined,
                        color: Colors.amber,
                        size: 30,
                      ),
                      hintText: 'Bergues'),
                ),
              ),
               Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: TextField(
                  controller: _arrivee,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_searching_outlined,
                        color: Colors.amber,
                        size: 30,
                      ),
                      hintText: 'Bergues'),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.amber,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$passager',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Passagers',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            passager += 1;
                          });
                        },
                        icon: Icon(
                          Icons.add_circle_rounded,
                          color: Colors.amber,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            passager -= 1;
                          });
                        },
                        icon: Icon(
                          Icons.remove_circle_rounded,
                          color: Colors.amber,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)))),
                  onPressed: () {
                    ajoutTrajet();
                  },
                  child: Text(
                    'Publier un trajet',
                    style: GoogleFonts.pacifico(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void ajoutTrajet() {
    try {
      laRefdelaBDD
          .collection('trajet')
          .add({"départ": _depart.toString(), "arrivée": _arrivee.toString()}).then(
              (value) => value.id);
    } catch (erreur) {
      print(erreur.toString());
    }
  }
}
