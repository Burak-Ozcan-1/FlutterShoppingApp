class AltCategory {
  int altKid;
  int ustKid;
  String kAdi; // telefon / telefon aksesuarları,
  //Icon altKresim;

  AltCategory({
    required this.altKid,
    required this.ustKid,
    required this.kAdi,
    //required this.altKresim,
  });

  static List<AltCategory> getKategori() {
    return [
      AltCategory(
        ustKid: 1,
        altKid: 1,
        kAdi: 'Telefon & Telefon Aksesuarları',
        //altKresim: //resim
      ),
      AltCategory(
        ustKid: 2,
        altKid: 1,
        kAdi: 'Ayakkabı & Çanta',
        //altKresim: //resim
      ),
      AltCategory(
        ustKid: 3,
        altKid: 1,
        kAdi: 'Mobilya',
        //altKresim: //resim
      ),
      AltCategory(
        ustKid: 4,
        altKid: 1,
        kAdi: 'Spor Giyim & Spor Aksesuar',
        //altKresim: //resim
      ),
      AltCategory(
        ustKid: 5,
        altKid: 1,
        kAdi: 'Kitap & Dergi',
        //altKresim: //resim
      ),
    ];
  }
}
