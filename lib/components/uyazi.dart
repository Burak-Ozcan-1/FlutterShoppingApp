import 'package:flutter/material.dart';

AppBar uyazi(String vText) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
    children: [
      Text(
        vText,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          decoration: TextDecoration.none, // alt çizgiyi siler.
        ),
      ),
      Isepet(),
    ]),
  );
}

Container Isepet() {
  return Container(
    alignment: Alignment.topRight,
    child: const Icon(
      Icons.shopping_cart_outlined,
      color: Colors.black,
      size: 40,
    ),
  );
}
