import 'package:co_voit/screen/detail_trajet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'creation_compte.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;

final userRefPhoto = FirebaseFirestore.instance.collection('user');

class consultationTrajet extends StatefulWidget {
  const consultationTrajet({
    Key? key,
  }) : super(key: key);

  @override
  State<consultationTrajet> createState() => _consultationTrajetState();
}

class _consultationTrajetState extends State<consultationTrajet> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  var heureFormat = DateFormat('HH:mm');
  String? photoUtilisateur;
  DateTime now = DateTime.now();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: Text(
            'Consulter les trajet',
            style: GoogleFonts.pacifico(color: Colors.white),
          ),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Center(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('trajet').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                // on regarde si la connection est bonne
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                // on regarde si j'ai pas d'erreur
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                print(snapshot.data!.docs);
                // je map les donnée

                List<QueryDocumentSnapshot<Map<String, dynamic>>> lesDonnes =
                    snapshot.data!.docs;
                print(lesDonnes);

                return Container(
                  margin: EdgeInsets.all(20),
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, int index) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //interieur de chaque container
                              GestureDetector(
                                onTap: () {
                                  // ci-dessous je passe les parametres pour la future vue
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => detailTrajet(
                                              depart: snapshot.data!.docs[index]
                                                  .data()['départ'],
                                              arrivee: snapshot
                                                  .data!.docs[index]
                                                  .data()['arrivée'],
                                              date: snapshot.data!.docs[index]
                                                  .data()['date'],
                                              user: snapshot.data!.docs[index]
                                                  .data()['nom'],
                                              userPhoto: snapshot
                                                  .data!.docs[index]
                                                  .data()['photoUser'])));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 0, 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //snapshot.data!.docs[index].data()['date'].toString()),
                                        Text(snapshot.data!.docs[index]
                                                    .data()['date'] !=
                                                null
                                            ? "Date: ${snapshot.data!.docs[index].data()['date'].toString()}"
                                            : "Date: "),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        // revoir le système d'heure
                                        Text(snapshot.data!.docs[index]
                                                    .data()['heure'] !=
                                                null
                                            ? "heure: ${snapshot.data!.docs[index].data()['heure'].toString()}:${snapshot.data!.docs[index].data()['minutes'].toString()}"
                                            : "heure: "),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(snapshot.data!.docs[index]
                                                    .data()['départ'] !=
                                                null
                                            ? "Départ: ${snapshot.data!.docs[index].data()['départ']}"
                                            : "Départ: "),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(snapshot.data!.docs[index]
                                                    .data()['arrivée'] !=
                                                null
                                            ? "Destination: ${snapshot.data!.docs[index].data()['arrivée']}"
                                            : "Destination: "),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .data()[
                                                              'photoUser'] ==
                                                          null
                                                      ? 'https://thumbs.dreamstime.com/b/man-icon-person-vector-worker-162495520.jpg'
                                                      : '${snapshot.data!.docs[index].data()['photoUser']}')),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text({
                                                          snapshot
                                                              .data!.docs[index]
                                                              .data()['nom']
                                                        } ==
                                                        null
                                                    ? 'De: Inconue'
                                                    : 'De: ${snapshot.data!.docs[index].data()['nom']}'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))),
                );
              }),
        ));
  }

 
  
}
