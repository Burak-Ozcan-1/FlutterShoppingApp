import 'package:todoapp/model/urunler.dart';

List<Urunler> urunlers = [];
List<double> toplamUrunTutari = [];

void SepeteAt(Urunler sepeteEkle) {
  urunlers.add(sepeteEkle);
}

void SepettenSil(int SilinecekId) {
  //urunlers.where();

  urunlers.removeWhere((element) => element.id == SilinecekId);
}

List<Urunler> SepetiGoster() {
  return urunlers;
}

void SepetiBosalt() {
  urunlers.clear();
}

double sepetToplamTutar() {
  double urunTutari = 0;
  for (Urunler element in urunlers) {
    urunTutari += element.tutar;
  }
  return urunTutari;
}
