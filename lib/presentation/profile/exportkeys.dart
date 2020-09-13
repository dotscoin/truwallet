import 'package:dio/dio.dart';
import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:truwallet/services/walletgenerate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ExportKeygenScreen extends StatefulWidget {
  @override
  _ExportKeygenScreenState createState() => _ExportKeygenScreenState();
}

class _ExportKeygenScreenState extends State<ExportKeygenScreen> {
  bool isloading;
  var data;
  var address;
  var vk;
  var sk;
  Future getdata() async {
    final stoarage = new FlutterSecureStorage();
    address = await stoarage.read(key: 'address');
    sk = await stoarage.read(key: 'sk');
    vk = await stoarage.read(key: 'vk');
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isloading = true;
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("TRUWALLET",
            style: TextStyle(color: Colors.blue, letterSpacing: 1.5)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Store these Securely ",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/banking.png", height: 200),
                      ],
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Address",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2)),
                            IconButton(
                              icon: Icon(Icons.content_copy),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: address));
                              },
                            )
                          ]),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${address}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ]),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Signing Key",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2)),
                            IconButton(
                              icon: Icon(Icons.content_copy),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: sk));
                              },
                            )
                          ]),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${sk}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                )),
                          ]),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Verifying Key",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2)),
                            IconButton(
                              icon: Icon(Icons.content_copy),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: vk));
                              },
                            )
                          ]),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("${vk}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                )),
                          ]),
                    ),
                    SizedBox(height: 15),
                  ]),
            )),
    );
  }
}
