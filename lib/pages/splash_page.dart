import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopping_list/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState

    Timer(Duration(seconds: 2),
        (() => Navigator.pushReplacementNamed(context, '/homepage')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
          child: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(text: 'Shopping', style: title1),
          TextSpan(
            text: 'List',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: semiBold,
              fontSize: 50,
            ),
          ),
        ]),
      )),
    );
  }
}
