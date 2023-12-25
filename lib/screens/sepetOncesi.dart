import 'package:flutter/material.dart';
import 'package:todoapp/components/alt_NavigationBar.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/screens/sepet.dart';

class SepetOncesi extends StatelessWidget {
  const SepetOncesi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ButtonTheme(
          minWidth: 10,
          child: ElevatedButton(
              child: const Text('Sepete Git'),
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MyBottomNav(
                      sepet: 1,
                    ),
                  ),
                );
              }),
        ),
        ButtonTheme(
          minWidth: 10,
          child: ElevatedButton(
              child: const Text('Alışverişe devam et'),
              onPressed: () {
                Navigator.pop(context);
                /*
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
                */
                 /*
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyApp()));
                        */
              }),
        ),
      ]),
    );
  }
}
