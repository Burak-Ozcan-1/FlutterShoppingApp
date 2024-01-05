import 'package:flutter/material.dart';

Dialog Yukleniyor() {
  return const Dialog(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        Text("  Yükleniyor"),
      ],
    ),
  );
}
