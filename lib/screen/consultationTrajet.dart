import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class consultationTrajet extends StatefulWidget {
  const consultationTrajet({Key? key}) : super(key: key);

  @override
  State<consultationTrajet> createState() => _consultationTrajetState();
}

class _consultationTrajetState extends State<consultationTrajet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Consulter les trajet',
        style: GoogleFonts.pacifico(
          color:Colors.white
        ),),
        backgroundColor: Colors.amber,
        centerTitle: true,

      ),
        body: Center(
      // child: FutureBuilder(
      //     future: FirebaseFirestore.instance
      //         .collection("trajet")
      //         .doc('test')
      //         .get(),
      //     builder: ((context, AsyncSnapshot snapshot) {
      //       print(snapshot.connectionState);
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return CircularProgressIndicator();
      //       }
      //       if (snapshot.hasError) {
      //         return Text(snapshot.error.toString());
      //       }
      //       print(snapshot.data.data());
      //       Map<String,dynamic> lesDonnees= snapshot.data.data();

      //       return Text(lesDonnees.toString());
      //     })),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('trajet').snapshots(),
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
                  itemBuilder: (context, index) => 
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)
                            ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [ 
                            
                            //interieur de chaque container
                            Container(
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
                                margin:EdgeInsets.fromLTRB(20, 10, 0, 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data!.docs[index].data()['départ'] !=null
                                    ? "Départ: ${snapshot.data!.docs[index].data()['départ']}"
                                    :"Départ: "),
                                    SizedBox(height: 10,),
                                     Text(snapshot.data!.docs[index].data()['arrivée'] !=null
                                    ? "Destination: ${snapshot.data!.docs[index].data()['arrivée']}"
                                    :"Destination: "),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"
                                          )
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
              )),
            );
          }),
    ));
  }
}
