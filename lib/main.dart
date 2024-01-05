import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/components/alt_NavigationBar.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/themes/lightMode.dart';

void main() async {
  ///// Sakın Silme FireBase Bağlantısı İçin.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  /////
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: home(),
    );
  }
}

Widget home() {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference notlarRef =
      _firestore.collection('Urunler'); //('UstKategori');

  return StreamBuilder<QuerySnapshot>(
    stream: notlarRef.snapshots(),
    builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
      //List<DocumentSnapshot> listOfDocumentSnap = asyncSnapshot.data.docs; //lenght
      if (asyncSnapshot.hasError) {
        return const Center(
          child: Text('Bilinmeyen Bir Hata Oluştu!'),
        );
      } else {
        if (asyncSnapshot.hasData) {
          return MyHomePage();
        }
      }
      return const Center(
        child: Text(''),
      );
    },
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MyBottomNav();
  }
}
