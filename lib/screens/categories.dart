import 'package:flutter/material.dart';
import 'package:todoapp/model/alt_category.dart';
import 'package:todoapp/model/urunler.dart';
import 'package:todoapp/model/ust_category.dart';
import 'package:todoapp/screens/home.dart';

class Categories extends StatefulWidget {
  Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

List<UstCategory> _ustKategor = [];
List<AltCategory> _altKategor = [];
//List<Urunler> urunler = [];

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    _ustKategor = UstCategory.getUstKategori();
    _altKategor = AltCategory.getKategori();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), //kapatıldı üstte boşluk atıyor.
      body: kategori(),
    );
  }

  ListView kategori() {
    return ListView.builder(
      itemCount: _ustKategor.length,
      itemBuilder: (context, index) {
        var groupName = _ustKategor[index].ustKadi;
        String items = _altKategor[index].kAdi;
        int p_UstKID = _altKategor[index].ustKid;
        int p_AltKID = _altKategor[index].altKid;
        int toplam = Urunler.getUrunler()
            .where(
              (i) =>
                  i.ustKid == p_UstKID &&
                  i.altKid == p_AltKID &&
                  i.yayinda == 1,
            )
            .length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grup adını göster
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                groupName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, itemIndex) {
                return ListTile(
                  title: Text(items + ' ' + '(' + toplam.toString() + ')'),
                  onTap: () {
                    if (toplam == 0) {
                      alertgoster(
                        items,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  ustKID: p_UstKID,
                                  altKID: p_AltKID,
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
