import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_voit/screen/menu.dart';
import 'package:co_voit/screen/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime aujourdhui = DateTime.now();
  DateTime? dateselectionnee = null;
  final dateFormat = DateFormat('dd-MM-yyyy');
  TimeOfDay? _heureselectionnee = null;

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
      body: SingleChildScrollView(
        child: Center(
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
            height: hauteur * 0.8,
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
                        hintText: 'Ville de départ'),
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
                        hintText: "Ville d'arrivée"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 10, 20),
                  child: GestureDetector(
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: aujourdhui,
                            firstDate: aujourdhui,
                            lastDate: DateTime(2100));
                        // si c'est cancel
                        if (newDate == null) return;
                        setState(() {
                          dateselectionnee = newDate;
                          final dateFormat =
                              DateFormat('dd-MM-yyyy').format(aujourdhui);
                        });
                        print(dateselectionnee);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                (dateselectionnee == null)
                                    ? 'Séléctionner une date'
                                    : dateFormat.format(
                                        dateselectionnee!,
                                      ),
                                style: stylePrincipal25,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 10, 20),
                  child: GestureDetector(
                      onTap: () async {
                        TimeOfDay? nouvelleHeure = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        // si c'est cancel
                        if (nouvelleHeure == null) return;
                        setState(() {
                          _heureselectionnee = nouvelleHeure;
                        });
                        print(_heureselectionnee);
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 40,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  (_heureselectionnee == null)
                                      ? 'Selectionner une heure'
                                      : _heureselectionnee!.format(context),
                                  style: stylePrincipal25,
                                ))
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          icon: const Icon(
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
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                    onPressed: () {
                      showSimpleDialog(context);
                    },
                    child: Text(
                      'Publier un trajet',
                      style: GoogleFonts.pacifico(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void ajoutTrajet() {
    try {
      laRefdelaBDD.collection('trajet').add({
        "départ": _depart.text,
        "arrivée": _arrivee.text,
        "Nbr de personnes": passager,
        "date": dateFormat.toString(),
        "heure": _heureselectionnee.toString()
      }).then((value) => value.id);
    } catch (erreur) {
      print(erreur.toString());
    }
  }

  void showSimpleDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: Text(
            'Voulez vous publier ce trajet ?',
            style: GoogleFonts.pacifico(color: Colors.white),
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
                    ajoutTrajet();
                    bottonDialog();
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
  bottonDialog() {
    return showModalBottomSheet(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) => Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Trajet Publié ! ',
                    style:
                        GoogleFonts.pacifico(color: Colors.white, fontSize: 25),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.amber),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => menuScreen()));
                      },
                      child: Text('Menu principal'))
                ],
              ),
            ));
  }
}
