import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/components/yukleniyor.dart';
import 'package:todoapp/screens/detail.dart';
import 'package:todoapp/services/firebase_img_service.dart';

class HomePage extends StatefulWidget {
  int? ustKID;
  int? altKID;
  HomePage({super.key, this.ustKID, this.altKID});

  @override
  State<HomePage> createState() => _HomePageState();
}

//Urunler
late List<Map<String, dynamic>> itemsUrunler;
var collectionUrunler =
    FirebaseFirestore.instance.collection('Urunler').orderBy('id');

bool isLoaded = false;
int aramaVar = 0; //arama alanına birşey yazılıp yazılmadığını kontrol eder.

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> urunlers = [];
  List<Map<String, dynamic>> urunlerkosullu = [];
  List<Map<String, dynamic>> _urunler = [];
  //para formatı
  final formatCurrency = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');

  void _getUrunler(int p_ustKid, int p_altKid) {
    if (p_ustKid == 0 || p_altKid == 0) {
      urunlers = itemsUrunler.where((map) {
        return map['yayinda'] == 1;
      }).toList(); //.toList();
    } else {
      urunlers = itemsUrunler.where((map) {
        return map['ustKategoriId'] == p_ustKid &&
            map['altKategoriId'] == p_altKid &&
            map['yayinda'] == 1;
      }).toList();
      if (urunlerkosullu.length == 0) {
        urunlers = itemsUrunler.where((map) {
          return map['yayinda'] == 1;
        }).toList();
      } else {
        urunlers = urunlerkosullu;
      }
    }

    if (aramaVar == 0) {
      // arama yoksa tüm listeyi getirir.
      _urunler = urunlers;
    }
  }

  @override
  void initState() {
    veriTabaniIslemi();
    if (isLoaded == false) {
      Yukleniyor();
    } else {
      if (widget.altKID == null && widget.ustKID == null) {
        _urunler = itemsUrunler.where((map) {
          return map['yayinda'] == 1;
        }).toList();
      } else {
        urunlerkosullu = itemsUrunler.where((map) {
          return map['ustKategoriId'] == widget.ustKID &&
              map['altKategoriId'] == widget.altKID &&
              map['yayinda'] == 1;
        }).toList();

        if (urunlerkosullu.length == 0) {
          _urunler = itemsUrunler.where((map) {
            return map['yayinda'] == 1;
          }).toList();
        } else {
          _urunler = urunlerkosullu;
        }
      }
    }
  }

  void getList(String value) {
    aramaVar = 1; //arama yapıldığı anda buraya düşer.
    List<Map<String, dynamic>> results = [];
    if (value.isEmpty) {
      results = urunlers;
    } else {
      if (widget.ustKID == null && widget.altKID == null) {
        results = itemsUrunler.where((map) {
          return map['adi'].toLowerCase().contains(value.toLowerCase()) &&
              map['yayinda'] == 1;
        }).toList();
      } else {
        results = itemsUrunler.where((map) {
          return map['adi'].toLowerCase().contains(value.toLowerCase()) &&
              map['ustKategoriId'] == widget.ustKID &&
              map['altKategoriId'] == widget.altKID &&
              map['yayinda'] == 1;
        }).toList();
      }
    }

    setState(() {
      _urunler = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded == false) {
      return Yukleniyor();
    } else {
      if (widget.ustKID == null && widget.altKID == null) {
        _getUrunler(0, 0);
      } else {
        _getUrunler(widget.ustKID!, widget.altKID!);
      }
      return Scaffold(
        resizeToAvoidBottomInset:
            false, // arama esnasında altta sarı şerit çıkmaması için
        appBar: AppBar(
          title: urunAra(),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                gryDecoration(), // arkaya griliği verir.
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    product(),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  TextField urunAra() {
    return TextField(
      onChanged: (value) => getList(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(15),
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintText: 'Ürün Ara',
      ),
    );
  }

  Container gryDecoration() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          )
        ],
      ),
    );
  }

  Container product() {
    //veriTabaniIslemi();
    return Container(
      child: GridView.builder(
        itemCount: _urunler.length, //urunlers.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(
                              value: _urunler[index]['id'],
                            )),
                  );
                },
                //child: Scrollbar(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.46,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x3600000F),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                child: FutureBuilder(
                                  future: FirebaseStorageService().getData(
                                      //urunler/telefon_aksesuar/Iphone13.jpg
                                      _urunler[index]['resim_url']),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Image.network(
                                        snapshot.data.toString(),
                                        height: 145,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: FittedBox(
                            fit: BoxFit.fitHeight, //BoxFit.cover,
                            child: Text(
                              _urunler[index]["adi"],
                              style: TextStyle(
                                fontSize: 15, // yazı boyutu
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: FittedBox(
                            fit: BoxFit.fitHeight, //BoxFit.cover,
                            child: Text(
                              '${formatCurrency.format(_urunler[index]["fiyat"])}',
                              style: TextStyle(
                                fontSize: 17, // yazı boyutu
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //),
              ),
            ],
          );
        },
      ),
    );
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
}
