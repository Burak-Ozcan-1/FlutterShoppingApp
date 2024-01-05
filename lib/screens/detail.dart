import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/components/Sepet/Fsepet.dart';
import 'package:todoapp/components/yukleniyor.dart';
import 'package:todoapp/screens/categories.dart';
import 'package:todoapp/screens/sepetOncesi.dart';
import 'package:todoapp/services/firebase_img_service.dart';

class Detail extends StatefulWidget {
  int value;
  Detail({super.key, required this.value});

  @override
  State<Detail> createState() => _Detail();
}

late List<Map<String, dynamic>> itemsUrunler;
var urunler = FirebaseFirestore.instance.collection('Urunler');

bool isLoaded = false;
int index = 0;

class _Detail extends State<Detail> {
  List<Map<String, dynamic>> details = [];

  @override
  void initState() {
    veriTabaniIslemi();
    super.initState();
  }

  void IdyeGoreBul(int p_value) {
    details = itemsUrunler.where((map) {
      return map['id'] == p_value && map['yayinda'] == 1;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded == false) {
      return Yukleniyor();
    } else {
      IdyeGoreBul(widget.value);
      return Scaffold(
        appBar: AppBar(),
        body: liste(),
      );
    }
  }

  ListView liste() {
    return ListView(
      children: <Widget>[
        FutureBuilder(
          future: FirebaseStorageService().getData(
              //urunler/telefon_aksesuar/Iphone13.jpg
              details[index]['resim_url']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Image.network(
                snapshot.data.toString(),
                fit: BoxFit.cover,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
          child: Center(
            child: uyazi('', details[index]['adi']),
          ),
          //child:
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
          child: uyazi('Ürün Tanımı: ', details[index]['tanim']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
          child: details[0]['renk'] == ''
              ? uyazi(' ', '')
              : uyazi('Ürün Rengi: ', details[index]['renk']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
          child: uyazi(
            'Stok Tarihi: ',
            DateFormat('dd.MM.yyyy')
                .format(
                  details[index]['ekleme_tarihi'].toDate(),
                )
                .toString(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ButtonTheme(
          minWidth: 10,
          child: ElevatedButton(
            child: const Text('Sepete Ekle'),
            //child: Text('Sepete Ekle'),
            onPressed: () {
              _Sepet();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SepetOncesi()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  void _Sepet() {
    SepeteAt(details);
  }

  veriTabaniIslemi() async {
    List<Map<String, dynamic>> tempListUrunler = [];
    var dataUrunler = await collectionUrunler.get();
    dataUrunler.docs.forEach((element) {
      tempListUrunler.add(element.data());
    });

    setState(() {
      itemsUrunler = tempListUrunler;
      isLoaded = true;
    });
  }

  Text uyazi(String vText, String vTanim) {
    return Text(
      vText + vTanim,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18.0 // alt çizgiyi siler.
          ),
    );
  }
}
