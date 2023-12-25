//detail sayfası burada ürün fiyatı ve ürün ile ilgili bilgiler yer alacak.
import 'package:flutter/material.dart';
import 'package:todoapp/components/Fsepet.dart';
import 'package:todoapp/model/urunler.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/screens/sepetOncesi.dart';

class Detail extends StatelessWidget {
  final Urunler value;
  const Detail({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Isepet(),
          //title: Text(value.adi),
          ),
      body: ListView(
        children: [
          Image.asset(
            value.resim == ''
                ? 'assets/images/ortak/noproduct.jpg'
                : value.resim, // boş ise yükleniyor resmi görüntülenecek.
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            child: Center(
              child: uyazi('', value.adi),
            ),
            //child:
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            child: uyazi('Ürün Tanımı: ', value.tanim),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            child: value.renk == ''
                ? uyazi(' ', '')
                : uyazi('Ürün Rengi: ', value.renk),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            child: uyazi(
                'Stok Tarihi: ',
                DateFormat('dd.MM.yyyy')
                    .format(value.ekleme_tarihi)
                    .toString()),
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
      ),
    );
  }

  void _Sepet() {
    SepeteAt(value);
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
