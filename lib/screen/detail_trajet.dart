import 'dart:ffi';

import 'package:co_voit/screen/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class detailTrajet extends StatelessWidget {
  final String depart;
  final String arrivee;
  final String date;
  final String user;
  final String userPhoto;

  detailTrajet(
      {Key? key,
      required this.depart,
      required this.arrivee,
      required this.date,
      required this.user,
      required this.userPhoto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text(
          "Détail de l'annonce",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(depart.toString(), style: stylePrincipal20)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.mode_standby_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(arrivee.toString(), style: stylePrincipal20)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.schedule_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Départ le : ${date.toString()} à 18h45',
                    style: stylePrincipal20)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Proposé par: ${user.toString()}', style: stylePrincipal20)
              ],
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(userPhoto.toString()),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "S'inscrire",
              style: stylePrincipal25,
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber)),
          )
        ]),
      ),
    );
  }
}
