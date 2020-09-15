import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:truwallet/presentation/intro/introscreen.dart';

class WalletsScreen extends StatefulWidget {
  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  bool loader;
  var addresses = [];
  var vk = [];
  var sk = [];
  var activeaddress;
  getwallets() async {
    final storage = new FlutterSecureStorage();
    var n = await storage.read(key: 'n');
    if (n != null) {
      int index = int.parse(n);
      for (var i = 1; i <= index; i++) {
        addresses.add(await storage.read(key: "address$i"));
        vk.add(await storage.read(key: "vk$i"));
        sk.add(await storage.read(key: "sk$i"));
      }
      activeaddress = await storage.read(key: 'address');
      setState(() {
        loader = false;
      });
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }

  @override
  void initState() {
    loader = true;
    super.initState();
    getwallets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Wallet", style: TextStyle(color: Colors.black)),
        ),
        body: loader
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(addresses[index],
                      style: TextStyle(color: Colors.black));
                }));
  }
}
