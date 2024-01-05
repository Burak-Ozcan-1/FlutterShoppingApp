List<Map<String, dynamic>> sepettekiUrunler = [];
//sepettekiUrunler veri tabanındaki ürünler
//buna ek olarak ürünün sepete atıldıktan sonra adet bilgisinin takibi için bir liste gerekiyor.
//buda sepettekiUrunDetay listesi içeriği  //Id , UrunAdedi, Fiyat//
List<Map<String, dynamic>> sepettekiUrunDetay = [];

void SepeteAt(List<Map<String, dynamic>> sepeteEkle) {
  for (var item in sepeteEkle) {
    sepettekiUrunler.add(item);

    //Id , UrunAdedi, Fiyat
    sepettekiUrunDetay.addAll([
      {"Id": item['id'], "UrunAdedi": 1, "Fiyat": item['fiyat']}
    ]);
    //mevcutUrunler.add(value)
  }
}

void SepettenSil(int SilinecekId) {
  sepettekiUrunler.removeWhere(
    (map) {
      return map['id'] == SilinecekId;
    },
  );

  sepettekiUrunDetay.removeWhere(
    (map) {
      return map['Id'] == SilinecekId;
    },
  );
}

List<Map<String, dynamic>> sepetiGoster() {
  return sepettekiUrunler;
}

void SepetiBosalt() {
  sepettekiUrunler.clear();
}

double sepetUrunToplamTutar() {
  int index = 0;
  //List<Map<String, dynamic>> sepettekiUrunDetayKosullu = [];
  double urunTutari = 0;

  for (var item in sepettekiUrunDetay) {
    //fiyatı double ' a çevirdik.
    urunTutari += item['Fiyat'].toDouble();
  }

  //urunTutari += sepettekiUrunDetay[index].values.elementAt(2).toDouble();
  //index += 1;
  return urunTutari;
}
