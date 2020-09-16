import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:truwallet/presentation/intro/introscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.blue, // navigation bar color
  //   statusBarColor: Colors.white12, // status bar color
  // ));
  runApp(Truwallet());
}

class Truwallet extends StatefulWidget {
  @override
  _TruwalletState createState() => _TruwalletState();
}

class _TruwalletState extends State<Truwallet> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRUWallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IntroScreen(),
    );
  }
}
