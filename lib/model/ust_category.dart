class UstCategory {
  int ustKid; // elektronik
  String ustKadi;
  //Icon ustKresim;

  UstCategory({
    required this.ustKid,
    required this.ustKadi,
    //required this.ustKresim,
  });

  static List<UstCategory> getUstKategori() {
    return [
      UstCategory(
        ustKid: 1,
        ustKadi: 'Elektronik',
        //ustKresim: Icon(Icons.electronic)
      ),
      UstCategory(
        ustKid: 2,
        ustKadi: 'Moda',
        //ustKresim:
      ),
      UstCategory(
        ustKid: 3,
        ustKadi: 'Ev, Yaşam, Kırtasiye, Ofis',
        //ustKresim:
      ),
      UstCategory(
        ustKid: 4,
        ustKadi: 'Spor, Outdoor',
        //ustKresim:
      ),
      UstCategory(
        ustKid: 5,
        ustKadi: 'Kitap, Müzik, Film, Hobi',
        //ustKresim:
      ),
    ];
  }
}
