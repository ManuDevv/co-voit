import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class menuScreen extends StatelessWidget {
  const menuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(right:15.0),
            child: Icon(Icons.person_outline),
          )  
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green
        ),
        child: ListView(
          children: [
            Card(
              color: Colors.transparent,
              
              child: Text('test'),
            )
          ],
        ),
      ),
    );
  }
}
