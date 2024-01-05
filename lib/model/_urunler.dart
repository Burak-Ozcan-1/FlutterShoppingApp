class Urunler {
  int id;
  String adi;
  String renk;
  int kategori; //1 Cep Telefonu , 2 Çanta , 3 Ayakkabı , 4 Mobilya, 5 Spor Giyim, 6 Spor Aksesuar, 7 Kitap
  String tanim;
  String resim;
  int stok;
  int yayinda; // 1 yayinda, 0 yayinda degil
  double tutar;
  int ustKid;
  int altKid;
  DateTime ekleme_tarihi;

  Urunler({
    required this.id,
    required this.adi,
    required this.renk,
    required this.kategori,
    required this.tanim,
    this.resim = '',
    //this.resim = Image.asset('assets/images/Iphone13.jpg'),
    //this.resim = Image.asset(' '), // Ürün resmi zorunlu değil boş olabilir.
    required this.stok,
    required this.yayinda,
    required this.tutar,
    required this.ustKid,
    required this.altKid,
    required this.ekleme_tarihi,
  });

  static List<Urunler> getUrunler() {
    return [
      Urunler(
        id: 1,
        adi: 'iPhone 13',
        renk: 'Kırmızı',
        kategori: 1,
        tanim: 'iPhone 13 128 GB',
        resim:
            'assets/images/telefon_aksesuar/Iphone13.jpg', //Image.asset('assets/images/Iphone13.jpg'), //,
        stok: 10,
        yayinda: 1,
        tutar: 36500,
        ustKid: 1,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 2,
        adi: 'Samsung A72',
        renk: 'Siyah',
        kategori: 1,
        tanim: 'Samsung A72 128 GB',
        resim:
            'assets/images/telefon_aksesuar/SamsungA72.jpg', //Image.asset('assets/images/SamsungA72.jpg'),
        stok: 5,
        yayinda: 1,
        tutar: 11500,
        ustKid: 1,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 3,
        adi: 'Nokia 6300',
        renk: 'Siyah',
        kategori: 1,
        tanim: 'Nokia 6300 Hafıza Kartı Var Çelik Kasa',
        stok: 1,
        yayinda: 0,
        tutar: 2.500,
        ustKid: 1,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 4,
        adi: 'Calvin Klein Çapraz Çanta',
        renk: 'Siyah',
        kategori: 2, //Çanta
        tanim: 'Calvin Klein Çapraz Çan, Standart, Siyah Boyut; 12x18x7,5',
        resim: 'assets/images/ayakkabi_canta/calvin_klein_siyah.jpg',
        stok: 10,
        yayinda: 1,
        tutar: 1999,
        ustKid: 2,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 5,
        adi: 'LumberJack Erkek Bot',
        renk: 'Siyah',
        kategori: 3, // Ayakkabı
        tanim: 'LumberJack Erkek Bot Kar Tipi Soğuk Geçirmez.',
        resim: 'assets/images/ayakkabi_canta/lumberjack_bot_erkek.jpg',
        stok: 5,
        yayinda: 1,
        tutar: 1000,
        ustKid: 2,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 6,
        adi: 'Polaris Bayan Mavi',
        renk: 'Mavi',
        kategori: 3, // Ayakkabı
        tanim: 'Polaris Mavi Bayan Ayakkabı Düz Taban Ayak Ağrıtmaz Özellikli',
        resim: 'assets/images/ayakkabi_canta/polaris_mavi_kadın.jpg',
        stok: 2,
        yayinda: 1,
        tutar: 500,
        ustKid: 2,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 7,
        adi: 'Ahşap Sallanan Koltuk',
        renk: 'Bej',
        kategori: 4, // Mobilya
        tanim:
            'İnsan vücuduna göre tasarlanmış ahşap ayak üstüne %100 pamuk döşeme. Okumak, televizyon izlemek ya da küçük bir şekerleme yapmak için doğru tercih olacaktır.',
        resim: 'assets/images/mobilya/ahsap_sallanan_koltuk.jpg',
        stok: 15,
        yayinda: 1,
        tutar: 9500,
        ustKid: 3,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 8,
        adi: 'Rüya Zigon Sehpa',
        renk: 'Ceviz',
        kategori: 4, // Mobilya
        tanim:
            'Geniş tablalı ve kaliteli malzeme kullanılarak sağlam paket ve ambalaj ile sevki sağlanmaktadır.Ürünlerimiz tamamen 1. sınıf MDF olup kesinlikle SUNTA Lâm ürün kullanmıyoruz. MDF ahşap malzemenin yarattığı sağlamlık, kabarma ve kararma gibi sorunlara karşı önlem oluşturur.',
        resim: 'assets/images/mobilya/zigon_sehpa.jpg',
        stok: 5,
        yayinda: 1,
        tutar: 1850,
        ustKid: 3,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 9,
        adi: 'Slazenge Kadın Eşofman Altı',
        renk: 'Siyah',
        kategori: 5, // Spor Giyim
        tanim:
            'Alt Grup Giyim Ürün Bilgileri Kumaş Malzemesi : %95 Polyester %5 Elastan Kumaş Tipi : 2 İplik Kalıp : Regular Fit Boy (cm) : 97 Bel (cm) : 37 Bel Tipi : Lastikli',
        resim: 'assets/images/spor_giyim_aksesuarlari/kadın_esofman_alti.jpg',
        stok: 15,
        yayinda: 1,
        tutar: 550,
        ustKid: 4,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 10,
        adi: 'Orta Boy Spor Çantası 45 cm',
        renk: 'Siyah',
        kategori: 6, // Spor Aksesuar
        tanim:
            '3 bölmeli (1 Ana Bölme 2 Yan fermuarlı bölme) full astarlı kaliteli kumaş birinci sınıf malzeme',
        resim:
            'assets/images/spor_giyim_aksesuarlari/orta_boy_spor_cantasi.jpg',
        stok: 8,
        yayinda: 1,
        tutar: 449.99,
        ustKid: 4,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 11,
        adi: 'Arkadaşım Dedem',
        renk: '',
        kategori: 7, // Kitap
        tanim:
            'Arkadaşım Dedem, bir çocukla dedesi arasındaki özel bağın mizahi ve içimizi ısıtan bir anlatımı. Torunların büyükleriyle paylaşabileceği mükemmel bir resimli hikâye kitabı!',
        resim: 'assets/images/kitap_dergi/arkadasim_dedem.jpg',
        stok: 3,
        yayinda: 1,
        tutar: 50.99,
        ustKid: 5,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
      Urunler(
        id: 12,
        adi: 'Doğanın Eşsiz Hikâyeleri 4',
        renk: '',
        kategori: 7, // Kitap
        tanim:
            'Küçük Yağmur Damlası Doğanın Eşsiz Hikâyeleri 4 - Melanie Joyce Gökten düşen bir yağmur damlası neler yaşar, hiç merak ettiniz mi? Öyleyse küçük yağmur damlasıyla tanışmalısınız!',
        resim: 'assets/images/kitap_dergi/kucuk_yagmur_damlasi.jpg',
        stok: 1,
        yayinda: 1,
        tutar: 45.99,
        ustKid: 5,
        altKid: 1,
        ekleme_tarihi: DateTime.now(),
      ),
    ];
  }
}
