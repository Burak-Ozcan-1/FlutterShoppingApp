import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/components/Sepet/Fsepet.dart';
import 'package:collection/collection.dart';
import 'package:todoapp/services/firebase_img_service.dart';

class Sepet extends StatefulWidget {
  const Sepet({super.key});

  @override
  State<Sepet> createState() => _Sepet();
}

int urunAdet = 1;
double toplamTutar = 0;
final formatCurrency = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');

class _Sepet extends State<Sepet> {
  @override
  void initState() {
    setState(() {
      toplamTutar = sepetUrunToplamTutar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: ifKontrol(),
    );
  }

  Widget ifKontrol() {
    if (sepetiGoster().isNotEmpty) {
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

  ListView listSepet() {
    Map groupItemsByCategory(List items) {
      return groupBy(items, (item) => item['id']);
    }

    Map groupedItems = groupItemsByCategory(sepetiGoster());
    return ListView.builder(
      itemCount: groupedItems.length, //SepetiGoster().length,
      itemBuilder: (context, index) {
        /*
        tumUrunlerLenght(
          index,
        );
        */
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder(
                  future: FirebaseStorageService().getData(
                      //urunler/telefon_aksesuar/Iphone13.jpg
                      sepetiGoster()[index]['resim_url']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Image.network(
                        snapshot.data.toString(),
                        height: 150,
                        //fit: BoxFit.cover,
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '  ' + sepetiGoster()[index]['adi'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
                      azaltveyaSilButon(index, sepetiGoster()[index]['id']),
                      urunAdedi(sepetiGoster()[index]['id']),
                      artirButon(index, sepetiGoster()[index]['id']),
                    ],
                  ),
                ),
                urunTutari(index, sepetiGoster()[index]['id']),
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

  void _arttir(int ilgiliUrunId, int index) {
    setState(() {
      urunAdet = mevcutUrunAdediBul(ilgiliUrunId);

      urunAdet += 1;

      var guncellenecekUrun =
          sepettekiUrunDetay.firstWhere((item) => item["Id"] == ilgiliUrunId);
      if (guncellenecekUrun != null) {
        guncellenecekUrun["UrunAdedi"] = urunAdet;
        guncellenecekUrun["Fiyat"] = sepetiGoster()[index]['fiyat'] * urunAdet;
      }

      toplamTutar += sepetiGoster()[index]['fiyat'].toDouble();
    });
  }

  void _azalt(int ilgiliUrunId, int index) {
    setState(() {
      urunAdet = mevcutUrunAdediBul(ilgiliUrunId);

      urunAdet -= 1;

      var guncellenecekUrun =
          sepettekiUrunDetay.firstWhere((item) => item["Id"] == ilgiliUrunId);
      if (guncellenecekUrun != null) {
        guncellenecekUrun["UrunAdedi"] = urunAdet;
        guncellenecekUrun["Fiyat"] = sepetiGoster()[index]['fiyat'] * urunAdet;
      }

      toplamTutar -= sepetiGoster()[index]['fiyat'].toDouble();
    });
  }

  IconButton azaltveyaSilButon(int index, int ilgiliUrunId) {
    //ürün adedi 1 iken sol tarafta sil simgesi çıkarmak için.
    if (mevcutUrunAdediBul(ilgiliUrunId) == 1) {
      return IconButton(
          onPressed: () {
            setState(() {
              toplamTutar = toplamTutar - sepetiGoster()[index]['fiyat'];
              SepettenSil(sepetiGoster()[index]['id']);
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
        //myList[1].keys.elementAt(0);
        sepettekiUrunDetay[veri].values.elementAt(1).toString(),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else {
      return Text('');
    }
  }

  //mevcutUrunler listesi ile ilgili işlemler başlangıç
  //kolay yoldan sepettekiUrunDetay 'a idye göre adet bulma.
  int mevcutUrunAdediBul(int ilgiliUrunId) {
    int kacinciIndex = sepettekiUrunDetay
        .indexWhere((element) => element["Id"] == ilgiliUrunId);
    urunAdet = sepettekiUrunDetay[kacinciIndex].values.elementAt(1);
    return urunAdet;
  }

  void mevcutUrunAdd(int index, int urunAdet, double fiyat) {
    sepettekiUrunDetay.addAll([
      {"Id": sepetiGoster()[index]['id'], "UrunAdedi": urunAdet, "Fiyat": fiyat}
    ]);
  }

  int mevcutUrunlerUrunVarmi(int urunId) {
    int sayi =
        sepettekiUrunDetay.indexWhere((element) => element["Id"] == urunId);
    return sayi;
  }

  void mevcutUrunListesiBosaltma() {
    toplamTutar = 0;
    setState(() {
      sepettekiUrunDetay.clear();
      SepetiBosalt();
    });
  }

  //mevcutUrunler listesi ile ilgili işlemler son
  Text urunTutari(int index, int ilgiliUrunId) {
    toplamTutar = sepetUrunToplamTutar();

    return Text(
      '${formatCurrency.format(sepettekiUrunDetay[index]['Fiyat'].toDouble())}',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  //Alışverişi Tamamla Butonu
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
