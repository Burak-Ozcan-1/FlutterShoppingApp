import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/components/yukleniyor.dart';
import 'package:todoapp/screens/home.dart';

class Categories extends StatefulWidget {
  Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

//Ust Kategori
late List<Map<String, dynamic>> itemsUstKategori;
var collectionUstKategori = //isGreaterThanOrEqualTo: searchKey)
    FirebaseFirestore.instance.collection('UstKategori').orderBy('ustKid');

//Alt Kategori
late List<Map<String, dynamic>> itemsAltKategori;
var collectionAltKategori =
    FirebaseFirestore.instance.collection('AltKategori').orderBy('ustKid');

//Urunler
late List<Map<String, dynamic>> itemsUrunler;
var collectionUrunler = FirebaseFirestore.instance.collection('Urunler');

bool isLoaded = false;

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    veriTabaniIslemi();
    return Scaffold(
      appBar: AppBar(), //kapatıldı üstte boşluk atıyor.
      body: Center(
        child: isLoaded ? kategori() : Yukleniyor(),
      ), //kategori(),
    );
  }

  ListView kategori() {
    return ListView.builder(
      itemCount: itemsUstKategori.length, //_ustKategor.length,
      itemBuilder: (context, index) {
        int tumUrunler = itemsUrunler.where((map) {
          return map['ustKategoriId'] == itemsUstKategori[index]["ustKid"] &&
              map['altKategoriId'] == itemsAltKategori[index]["altKid"] &&
              map['yayinda'] == 1;
        }).length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grup adını göster
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                itemsUstKategori[index]["ustKadi"],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, itemIndex) {
                return ListTile(
                  title: Text(itemsAltKategori[index]["kAdi"] +
                      ' ' +
                      '(' +
                      tumUrunler.toString() +
                      ')'),
                  onTap: () {
                    if (tumUrunler == 0) {
                      alertgoster(
                        itemsAltKategori[index]["kAdi"], //items,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  ustKID: itemsAltKategori[index]["ustKid"],
                                  altKID: itemsAltKategori[index]["altKid"],
                                )),
                      );
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  veriTabaniIslemi() async {
    //Ust Kategori Listesi
    List<Map<String, dynamic>> tempListUstKategori = [];
    var dataUstKategori = await collectionUstKategori.get();
    dataUstKategori.docs.forEach((element) {
      tempListUstKategori.add(element.data());
    });
    //alt Kategori Listesi
    List<Map<String, dynamic>> tempListAltKategori = [];
    var dataAltKategori = await collectionAltKategori.get();
    dataAltKategori.docs.forEach((element) {
      tempListAltKategori.add(element.data());
    });

    List<Map<String, dynamic>> tempListUrunler = [];
    var dataUrunler = await collectionUrunler.get();
    dataUrunler.docs.forEach((element) {
      tempListUrunler.add(element.data());
    });

    setState(() {
      itemsUstKategori = tempListUstKategori;
      itemsAltKategori = tempListAltKategori;
      itemsUrunler = tempListUrunler;
      isLoaded = true;
    });
  }

  alertgoster(String kategoriAdi) {
    Widget okButton = TextButton(
      child: const Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Uyarı"),
      content: Text("${kategoriAdi + ' Kategorisinde Ürün Bulunamadı!'}"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
