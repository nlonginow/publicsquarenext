import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:publicsquarenext/register.dart';
import 'package:publicsquarenext/support.dart';
import 'about.dart';
import 'home.dart';

//void main() {
//  runApp(const PrimaryApp());
//}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const PrimaryApp(),
      routes: {
        '/register': (context) =>  Register(),
        '/about': (context) => About(),
        '/support' : (context) => Support(),
//        '/about': (context) => const AboutScreen()
      },
    );
  }
}

