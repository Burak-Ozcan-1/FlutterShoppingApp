import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  String? downloadURL;
  Future getData(String Url) async {
    try {
      await test(Url);
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future test(String p_Url) async {
    if (p_Url == "") {
      p_Url = "urunler/ortak/noproduct.jpg";
    }

    //FirebaseFirestore.instance.collection('Urunler').orderBy('id');
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child(p_Url.toString())
        .getDownloadURL();
    debugPrint(downloadURL.toString());
  }
  /*
  Future<void> downloadURLExample() async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child("")
        //.child("urunler/")
        //.child("telefon_aksesuar/")
        //.child("Iphone13.jpg")
        //.child("Flutter.png")
        .getDownloadURL();
    debugPrint(downloadURL.toString());
  }
  */
}
