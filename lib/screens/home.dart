import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/model/urunler.dart';
import 'package:todoapp/screens/detail.dart';

//import 'package:todoapp/screens/uyazi.dart';
//import 'package:todoapp/model/urunler.dart';

class HomePage extends StatefulWidget {
  int? ustKID;
  int? altKID;
  HomePage({super.key, this.ustKID, this.altKID});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Urunler> urunlers = [];
  List<Urunler> urunlerkosullu = [];
  List<Urunler> _urunler = [];
  //para formatı
  final formatCurrency = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');

  void _getUrunler(int p_ustKid, int p_altKid) {
    if (p_ustKid == 0 || p_altKid == 0) {
      urunlers = Urunler.getUrunler()
          .where(
            (a) => a.yayinda == 1,
          )
          .toList();
      ;
    } else {
      urunlerkosullu = Urunler.getUrunler()
          .where(
            (i) =>
                i.ustKid == p_ustKid && i.altKid == p_altKid && i.yayinda == 1,
          )
          .toList();

      if (urunlerkosullu.length == 0) {
        urunlers = Urunler.getUrunler()
            .where(
              (a) => a.yayinda == 1,
            )
            .toList();
      } else {
        urunlers = urunlerkosullu;
      }
    }
  }

  @override
  void initState() {
    if (widget.altKID == null && widget.ustKID == null) {
      _urunler = Urunler.getUrunler()
          .where(
            (a) => a.yayinda == 1,
          )
          .toList();
      super.initState();
    } else {
      urunlerkosullu = Urunler.getUrunler()
          .where(
            (i) =>
                i.ustKid == widget.ustKID &&
                i.altKid == widget.altKID &&
                i.yayinda == 1,
          )
          .toList();

      if (urunlerkosullu.length == 0) {
        _urunler = Urunler.getUrunler()
            .where(
              (a) => a.yayinda == 1,
            )
            .toList();
        super.initState();
      } else {
        _urunler = urunlerkosullu;
        super.initState();
      }
    }
  }

  void getList(String value) {
    List<Urunler> results = [];
    if (value.isEmpty) {
      results = urunlers;
    } else {
      if (widget.ustKID == null && widget.altKID == null) {
        results = Urunler.getUrunler()
            .where(
              (element) =>
                  element.adi.toLowerCase().contains(value.toLowerCase()) &&
                  element.yayinda == 1,
            )
            .toList();
      } else {
        results = Urunler.getUrunler()
            .where(
              (element) =>
                  element.adi.toLowerCase().contains(value.toLowerCase()) &&
                  element.ustKid == widget.ustKID &&
                  element.altKid == widget.altKID &&
                  element.yayinda == 1,
            )
            .toList();
      }
    }

    setState(() {
      _urunler = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ustKID == null || widget.altKID == null) {
      print('deneme');
      _getUrunler(0, 0);
    } else {
      _getUrunler(widget.ustKID!, widget.altKID!);
    }

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // arama esnasında altta sarı şerit çıkmaması için.s
      appBar: AppBar(
        title: urunAra(),
      ),
      body: Stack(
        children: [
          gryDecoration(), // arkaya griliği verir.
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                //height: 650,
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height) * 20.5 / 100,
                child: product(),
              ),
            ],
          ) //,
          //product(),
        ],
      ),
    );
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
      //margin: EdgeInsets.only(top: 10, left: 20, right: 20),
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
                              value: _urunler[index],
                            )),
                  );
                },
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
                    //padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                child: Image.asset(
                                  urunlers[index].resim == ''
                                      ? 'assets/images/ortak/noproduct.jpg'
                                      : _urunler[index]
                                          .resim, //item.resim, // boş ise yükleniyor resmi görüntülenecek.
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 20,
                          child: FittedBox(
                            fit: BoxFit.fitHeight, //BoxFit.cover,
                            child: Text(
                              _urunler[index].adi,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.fitHeight, //BoxFit.cover,
                            child: Text(
                              //
                              //Text('}',
                              '${formatCurrency.format(_urunler[index].tutar)}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
