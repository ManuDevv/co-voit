import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:co_voit/services/liste_ville.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final user = FirebaseAuth.instance.currentUser!.uid;
final userRef = FirebaseFirestore.instance.collection('user');
FirebaseStorage storage = FirebaseStorage.instance;

class testAutoComplete extends StatefulWidget {
  testAutoComplete({Key? key}) : super(key: key);

  @override
  State<testAutoComplete> createState() => _testAutoCompleteState();
}

class _testAutoCompleteState extends State<testAutoComplete> {
  String? villeselectionee;
  late List<DocumentSnapshot> _docs;
  String? _userPhotoUrl;
  @override
  void initState() {
    getProfilImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Column(children: [
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable.empty();
            }
            return listVille.where((element) {
              return element.contains(textEditingValue.text);
            });
          },
          onSelected: (String ville) {
            setState(() {
              villeselectionee = ville;
            });
          },
        ),
        ElevatedButton(
            onPressed: () {
              print(villeselectionee);
            },
            child: Text('test')),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/co-voit-85111.appspot.com/o/Users%2Fimages%2F65kPWlZp57h8IHO5E4LZ0ww1inJ2?alt=media&token=8d9ccc2b-36af-458b-9737-4e3209862d4e'),
        // StreamBuilder(
        //     stream: userRef.snapshots(),
        //     builder: (context, AsyncSnapshot snapshot) {
        //       if (!snapshot.hasData) {
        //         return CircularProgressIndicator();
        //       }
        //       return ListView(children: [
        //         snapshot.data.docs.map(
        //           (document) {
        //             return Image.network(document['userImage']);
        //           },
        //         ).toList()
        //       ]);
        //     }),
        Container(
          height: 200,
          width: 200,
          child: Image.network(_userPhotoUrl == null
              ? 'https://firebasestorage.googleapis.com/v0/b/co-voit-85111.appspot.com/o/images%2FcSVqVsw2eRgZtGvK9uKJ5M2Yt6e2?alt=media&token=2457371b-3af8-4f0f-9a5a-9bd97b184e39'
              : '${_userPhotoUrl.toString()}'),
        )
      ]),
    )));
  }

  getProfilImage() {
    Reference ref = storage.ref().child("Users/images/$user");
    ref.getDownloadURL().then((downloadUrl) {
      setState(() {
        _userPhotoUrl = downloadUrl.toString();
        print(_userPhotoUrl);
      });
    }).catchError((e) {
      setState(() {
        print('Un problème est survenu: ${e.error}');
      });
    });
  }
}
// Container(
//                 child: Column(
//                     children: snapshot.data.docs.map((docuement) {
//                   return Image.network(docuement['userImage']);
//                 })
//                 ),
//               );