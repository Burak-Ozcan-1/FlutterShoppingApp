import 'package:flutter/material.dart';
import 'package:todoapp/components/Sepet/Fsepet.dart';
import 'package:todoapp/screens/account.dart';
import 'package:todoapp/screens/categories.dart';
import 'package:todoapp/screens/home.dart';
import 'package:todoapp/screens/sepet.dart';

List pages = [
  HomePage(),
  const Sepet(),
  Categories(),
  const Account(),
];

class MyBottomNav extends StatefulWidget {
  int? sepet = 0;

  MyBottomNav({super.key, this.sepet});

  @override
  MyBottomNavState createState() {
    return MyBottomNavState();
  }
}

class MyBottomNavState extends State<MyBottomNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (sepetiGoster().length != 0 && widget.sepet == 1) {
      widget.sepet = 0;
      _currentIndex = 1;
      return Scaffold(
        body: pages[1],
        bottomNavigationBar: menu(),
      );
    } else {
      return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: menu(),
      );
    }
  }

  BottomNavigationBar menu() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      //backgroundColor: Color(0x3600000F),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      selectedFontSize: 10,
      unselectedFontSize: 10,
      currentIndex: _currentIndex,
      iconSize: 30,
      elevation: 0,
      onTap: (index) {
        setState(() => _currentIndex = index);
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Ana Sayfa',
          icon: Icon(
            Icons.home,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Sepet',
          icon: Icon(
            Icons.shopping_cart_outlined,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Kategoriler',
          icon: Icon(
            Icons.category_outlined,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Hesap',
          icon: Icon(
            Icons.person_pin_circle_outlined,
          ),
        ),
      ],
    );
  }
}
