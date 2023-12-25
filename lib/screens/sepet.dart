import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/components/Fsepet.dart';
import 'package:collection/collection.dart';
import 'package:todoapp/model/urunler.dart';

class Sepet extends StatefulWidget {
  const Sepet({super.key});

  @override
  State<Sepet> createState() => _Sepet();
}

List<Urunler> ilgiliUrun = [];

List<Map<String, dynamic>>? mevcutUrunler;
//int p_List = 0;
int urunAdet = 1;
int ilkAdet = 1;
double toplamTutar = 0;
//= 0;
final formatCurrency = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');

class _Sepet extends State<Sepet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: ifKontrol(),
    );
  }

  Widget ifKontrol() {
    //urunAdet = 1;
    if (SepetiGoster().isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // use whichever suits your need
                children: [
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Sepetim",
                  ),
                  IconButton(
                    iconSize: 35,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      print('tiklandi');
                      mevcutUrunListesiBosaltma();
                    },
                  ),
                ],
              ),
            ],
          ),

          //Text('Sepetim'),
        ),
        body: Stack(
          children: [
            listSepet(),
          ],
        ),
        bottomNavigationBar: bottomSepet(),
      ); //
    } else {
      return Scaffold(
        appBar: AppBar(
          //title: Text(),
          centerTitle: true,
        ),
        body: const Text(
          '             Sepetin şu an boş \n   \n        Sepetinize Ürün Eklemek \n         İçin Ana Sayfaya Gidiniz',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  void tumUrunlerLenght(int index) {
    int veri;
    if (mevcutUrunler == null) {
      urunAdet = 1;
      mevcutUrunler = [
        {"Id": SepetiGoster()[index].id, "UrunAdedi": urunAdet}
      ];
    } else {
      urunAdet = 1;
      veri = mevcutUrunler!
          .indexWhere((element) => element["Id"] == SepetiGoster()[index].id);
      if (veri == -1) {
        mevcutUrunAdd(index, urunAdet);
      }
    }

    ilgiliUrun = SepetiGoster()
        .where((element) =>
            element.id.toString().contains(SepetiGoster()[index].id.toString()))
        .toList();

    ilgiliUrun
        .where((element) => element.id == SepetiGoster()[index].id)
        .length;
  }

  void _arttir(int ilgiliUrunId, int index) {
    setState(() {
      urunAdet = mevcutUrunAdediBul(ilgiliUrunId);
      //mevcutUrunAdedi listesinden idye göre Mevcut Adedi Bulma.

      //
      //mevcutUrunAdedi listesinden IlgiliUrunId ye göre silme işlemi
      mevcutUrunler!.removeWhere((element) => element["Id"] == ilgiliUrunId);

      //sepetToplamTutar();

      //adet değişkenini bir artırma
      urunAdet++;

      //toplamTutar = urunAdet * SepetiGoster()[index].tutar;
      //oplamTutar += SepetiGoster()[index].tutar;

      toplamTutar = toplamTutar + SepetiGoster()[index].tutar;

      //ilgili urunu listeye tekrar ekleme.
      mevcutUrunAdd(index, urunAdet);

      /*
      mevcutUrunAdedi!.addAll([
        {"Id": SepetiGoster()[index].id, "UrunAdedi": urunAdet}
      ]);
      */
    });
  }

  void mevcutUrunListesiBosaltma() {
    toplamTutar = 0;
    //urunAdet = 1;
    setState(() {
      mevcutUrunler!.clear();
      SepetiBosalt();
    });
  }

  void _azalt(int ilgiliUrunId, int index) {
    setState(() {
      urunAdet = mevcutUrunAdediBul(ilgiliUrunId);
      //mevcutUrunAdedi listesinden idye göre Mevcut Adedi Bulma.

      //
      //mevcutUrunAdedi listesinden IlgiliUrunId ye göre silme işlemi
      mevcutUrunler!.removeWhere((element) => element["Id"] == ilgiliUrunId);

      //adet değişkenini bir azaltma
      urunAdet--;

      //toplamTutar -= urunAdet * SepetiGoster()[index].tutar;
      toplamTutar -= SepetiGoster()[index].tutar;

      //ilgili urunu listeye tekrar ekleme.
      mevcutUrunAdd(index, urunAdet);
      /*
      mevcutUrunAdedi!.addAll([
        {"Id": SepetiGoster()[index].id, "UrunAdedi": urunAdet}
      ]);
      */
    });
  }

  IconButton azaltveyaSil(int index, int ilgiliUrunId) {
    //ürün adedi 1 iken sol tarafta sil simgesi çıkarmak için.
    if (mevcutUrunAdediBul(ilgiliUrunId) == 1) {
      return IconButton(
          onPressed: () {
            setState(() {
              toplamTutar = toplamTutar - SepetiGoster()[index].tutar;
              SepettenSil(SepetiGoster()[index].id);
            });
          },
          icon: const Icon(Icons.delete));
    } else {
      return IconButton(
          onPressed: () {
            _azalt(ilgiliUrunId, index);
          },
          icon: const Icon(Icons.remove));
    }
  }

  IconButton artirButon(int index, int ilgiliUrunId) {
    return IconButton(
        onPressed: () {
          _arttir(ilgiliUrunId, index);
        },
        icon: const Icon(Icons.add));
  }

  Text urunAdedi(int urunId) {
    int veri = mevcutUrunlerUrunVarmi(urunId);
    if (veri != -1) {
      return Text(
        mevcutUrunler![veri].values.last.toString(),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else {
      return Text('');
    }
  }

  //mevcutUrunler listesi ile ilgili işlemler başlangıç
  int mevcutUrunAdediBul(int ilgiliUrunId) {
    int kacinciIndex =
        mevcutUrunler!.indexWhere((element) => element["Id"] == ilgiliUrunId);
    urunAdet = mevcutUrunler![kacinciIndex].values.last;
    return urunAdet;
  }

  void mevcutUrunAdd(int index, int urunAdet) {
    mevcutUrunler!.addAll([
      {"Id": SepetiGoster()[index].id, "UrunAdedi": urunAdet}
    ]);
  }

  int mevcutUrunlerUrunVarmi(int urunId) {
    int sayi = mevcutUrunler!.indexWhere((element) => element["Id"] == urunId);
    return sayi;
  }

  @override
  void initState() {
    setState(() {
      //urunAdet = 1;
      toplamTutar = sepetToplamTutar();
    });
  }

  //mevcutUrunler listesi ile ilgili işlemler son
  Text urunTutari(int index, int ilgiliUrunId) {
    //toplamTutar = urunAdet * SepetiGoster()[index].tutar;
    //toplamTutar = sepetToplamTutar(); //+ toplamTutar;
    toplamTutar = sepetToplamTutar() * mevcutUrunAdediBul(ilgiliUrunId);
    //toplamTutar = toplamTutar * mevcutUrunAdediBul(ilgiliUrunId);
    return Text(
      '${formatCurrency.format(SepetiGoster()[index].tutar * mevcutUrunAdediBul(ilgiliUrunId))}',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  ListView listSepet() {
    Map groupItemsByCategory(List items) {
      return groupBy(items, (item) => item.id);
    }

    Map groupedItems = groupItemsByCategory(SepetiGoster());
    return ListView.builder(
      itemCount: groupedItems.length, //SepetiGoster().length,
      itemBuilder: (context, index) {
        tumUrunlerLenght(
          index,
          //SepetiGoster()[index].id,
        );
        return Column(
          children: [
            Row(
              children: [
                Image.asset(
                  SepetiGoster()[index].resim == ''
                      ? 'assets/images/ortak/noproduct.jpg'
                      : SepetiGoster()[index]
                          .resim, //item.resim, // boş ise yükleniyor resmi görüntülenecek.
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '  ' + SepetiGoster()[index].adi,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {},
                  label: Row(
                    children: [
                      azaltveyaSil(index, SepetiGoster()[index].id),
                      urunAdedi(SepetiGoster()[index].id),
                      artirButon(index, SepetiGoster()[index].id),
                    ],
                  ),
                ),
                urunTutari(index, SepetiGoster()[index].id),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        );
      },
    );
  }

  BottomAppBar bottomSepet() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Toplam Tutar : ' + toplamTutar.toString(),
          ),
          ButtonTheme(
            minWidth: 10,
            child: ElevatedButton(
              child: const Text('Alışverişi Tamamla'),
              //child: Text('Sepete Ekle'),
              onPressed: () {},
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
}
