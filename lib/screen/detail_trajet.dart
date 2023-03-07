import 'package:co_voit/screen/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class detailTrajet extends StatefulWidget {
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
  State<detailTrajet> createState() => _detailTrajetState();
}

class _detailTrajetState extends State<detailTrajet> {
  int _nbr_passager = 0;

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
                Text(widget.depart.toString(), style: stylePrincipal20)
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
                Text(widget.arrivee.toString(), style: stylePrincipal20)
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
                Text('Départ le : ${widget.date.toString()} à 18h45',
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
                Text('Proposé par: ${widget.user.toString()}',
                    style: stylePrincipal20)
              ],
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(widget.userPhoto.toString()),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
            onPressed: () {
              inscription();
            },
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

  inscription() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Incription',
                style: GoogleFonts.pacifico(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              content: StatefulBuilder(
                  builder: (BuildContext ctx, StateSetter state) {
                return Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.green
                  ),
                  child: Column(
                    children: [
                      Text("S'incrire"),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {

                                
                                setState(() {
                               
                                });
                              
                              },
                              icon: Icon(Icons.add_rounded)),
                          
                        ],
                      )
                    ],
                  ),
                );
              }),
            ));
  }
}
