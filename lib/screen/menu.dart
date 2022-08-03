import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class menuScreen extends StatelessWidget {
  const menuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Menu Principal',
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.person_outline),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.green),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: hauteur*0.1,
                child: Card(
                  
                    elevation: 10.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.control_point_outlined,
                          color: Colors.amber,
                          size: 40,),
                        ),
                        Text("Je crée un trajet",
                            style: GoogleFonts.pacifico(
                              color: Colors.amber,
                              fontSize: 20,
                            )),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: hauteur*0.1,
                child: Card(
                  
                    elevation: 10.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.search,
                          color: Colors.amber,
                          size: 40,),
                        ),
                        Text("Je cherche un trajet",
                            style: GoogleFonts.pacifico(
                              color: Colors.amber,
                              fontSize: 20,
                            )),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
