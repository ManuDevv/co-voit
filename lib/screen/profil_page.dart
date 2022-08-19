import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_voit/screen/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

class profilPage extends StatefulWidget {

  profilPage({Key? key }) : super(key: key);

  @override
  State<profilPage> createState() => _profilPageState();
}

class _profilPageState extends State<profilPage> {
  File? _image;
  FirebaseStorage storage = FirebaseStorage.instance;
  String? photoUtilisateur;
  String uid = 'gdYg68kjgyyM5fZhRKlY';

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
                  backgroundImage: NetworkImage('$photoUtilisateur'),

                  // 'https://www.jeancoutu.com/globalassets/revamp/photo/conseils-photo/20160302-01-reseaux-sociaux-profil/photo-profil_301783868.jpg'),
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
                      getprofilImage();
                    },
                    child: Text('Confirmer la photo de profile'),
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                  ),
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('nameUser')
                        .doc(uid)
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      print(snapshot.data!.data());
                      return Column(
                        children: [
                          Text('Nom : ${snapshot.data!.data()!['nom']}'),
                          Text('')
                       
                        ],
                      );
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

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  // fonction pour prendre une photo de la caméra
  Future getImageCamera() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

// fonction pour envoyer la photo à firebase
  Future uploadFile() async {
    Reference storageRef = storage.ref('Users').child('test.png');
    UploadTask uploadTask = storageRef.putFile(_image!);
    await uploadTask.whenComplete(() {
      print('File Uploaded');
    });
  }

// fonction pour récupérer la photo dans firebase
  getprofilImage() {
    Reference storageRef = storage.ref('Users').child('test.png');
    storageRef.getDownloadURL().then((photo) {
      setState(() {
        photoUtilisateur = photo;
      });
    });
  }

 
}
