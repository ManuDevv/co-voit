import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_voit/screen/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
String _userdisplayName =
    FirebaseAuth.instance.currentUser!.displayName.toString();

class profilPage extends StatefulWidget {
  profilPage({Key? key}) : super(key: key);

  @override
  State<profilPage> createState() => _profilPageState();
}

class _profilPageState extends State<profilPage> {
  File? _image;
  FirebaseStorage storage = FirebaseStorage.instance;
  String? photoUtilisateur;

  final picker = ImagePicker();
  @override
  void initState() {
    getprofilImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Page de profil',
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            "Co-Voit",
            style: stylePrincipal40,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(photoUtilisateur == null
                      ? 'https://www.jeancoutu.com/globalassets/revamp/photo/conseils-photo/20160302-01-reseaux-sociaux-profil/photo-profil_301783868.jpg'
                      : photoUtilisateur.toString()),
                  radius: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Changer la photo de profil',
                    style: styleprincipalAmber20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          getImageGallery();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Icon(Icons.collections_outlined),
                              Text('Gallery'),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          fixedSize: Size(130, 50),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          getImageCamera();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              Icon(Icons.photo_camera),
                              Text('Appareil photo'),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(130, 50), primary: Colors.amber))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      uploadFile();
                    },
                    child: Text('Confirmer la photo de profile'),
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                  ),
                ),
                StreamBuilder(
                    stream: _firebaseAuth.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        print(snapshot.data.toString());
                        var currenttest = FirebaseAuth
                            .instance.currentUser!.displayName
                            .toString();
                        return Text('Nom: $currenttest');
                      } else {
                        return Text('');
                      }
                    })
              ],
            ),
          )
        ],
      )),
    );
  }

// fonction pour prendre une photo de la gallerie
  Future getImageGallery() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    // String addPhoto =
    //     await FirebaseAuth.instance.currentUser!.photoURL.toString();

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // fonction pour prendre une photo de la caméra
  Future getImageCamera() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    // String addPhoto =
    //     await FirebaseAuth.instance.currentUser!.photoURL.toString();

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

//fonction pour envoyer la photo à firebase
  Future uploadFile() async {
    Reference storageRef =
        storage.ref('Users').child("images/${_firebaseAuth.currentUser!.uid}");
    UploadTask uploadTask = storageRef.putFile(_image!);
    await uploadTask.whenComplete(() {
      print('File Uploaded');
    });

    final User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    final imageUrl = await storageRef.getDownloadURL();
    print(imageUrl);
    FirebaseFirestore.instance
        .collection('user')
        .doc(_uid)
        .set({'userImage': imageUrl});
  }

// fonction pour récupérer la photo dans firebase
  getprofilImage() {
    Reference storageRef =
        storage.ref().child("Users/images/${_firebaseAuth.currentUser!.uid}");
    storageRef.getDownloadURL().then((photo) {
      setState(() {
        photoUtilisateur = photo.toString();
      });
    });
    print(_firebaseAuth.currentUser!.uid);
  }

  // refreshPage(context) {
  //   Navigator.pushReplacement(
  //       context,
  //       PageRouteBuilder(
  //           pageBuilder: (_, __, ___) => profilPage(),
  //           transitionDuration: Duration(seconds: 1)));
  // }
}
