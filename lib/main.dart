import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:truwallet/presentation/intro/introscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truwallet/presentation/intro/loader.dart';

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
  var auth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final storage = new FlutterSecureStorage();
    auth = storage.read(key: 'touchid');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRUWallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: auth != null ? LoadingScreen() : IntroScreen(),
    );
  }
}
