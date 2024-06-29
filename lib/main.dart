import 'package:flutter/material.dart';
import 'package:shopping_list/models/editNotePage.dart';
import 'package:shopping_list/pages/splash_page.dart';
import 'package:shopping_list/pages/home_page.dart'; // Import file home_page.dart yang berisi HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Perbaiki deklarasi konstruktor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/homepage': (context) => HomePage(),
        // '/menu': (context) => drawer(),
      },
    );
  }
}
