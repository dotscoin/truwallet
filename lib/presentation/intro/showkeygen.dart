import 'package:dio/dio.dart';
import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:truwallet/services/walletgenerate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShowKeygenScreen extends StatefulWidget {
  @override
  _ShowKeygenScreenState createState() => _ShowKeygenScreenState();
}

class _ShowKeygenScreenState extends State<ShowKeygenScreen> {
  bool isloading;
  var data;
  Future getdata() async {
    Dio dio = new Dio();
    var response = await dio.get('http://dotswallet.dotscoin.com/genaddress');
    print("ok");
    print(response);
    print(response.data['address']);
    setState(() {
      data = response.data;
      isloading = false;
    });
  }

  storeandroute() async {
    final storage = new FlutterSecureStorage();
    var index = await storage.read(key: 'n');

    if (index != null) {
      int n = int.parse(index);
      n = n + 1;
      await storage.delete(key: 'n');
      await storage.write(key: 'address$n', value: data['address']);
      await storage.write(key: 'vk$n', value: data['vk']);
      await storage.write(key: 'sk$n', value: data['sk']);
      await storage.write(key: 'n', value: "$n");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      int n = 1;
      await storage.write(key: 'address$n', value: data['address']);
      await storage.write(key: 'vk$n', value: data['vk']);
      await storage.write(key: 'sk$n', value: data['sk']);
      await storage.write(key: 'n', value: "$n");
      await storage.delete(key: 'n');
      await storage.write(key: 'address', value: data['address']);
      await storage.write(key: 'vk', value: data['vk']);
      await storage.write(key: 'sk', value: data['sk']);
      await storage.write(key: 'n', value: "$n");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          storeandroute();
        },
        child: Icon(Icons.arrow_forward_ios),
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
                                Clipboard.setData(
                                    ClipboardData(text: data['address']));
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
                              "${data['address']}",
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
                                Clipboard.setData(
                                    ClipboardData(text: data['sk']));
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
                            Text("${data['sk']}",
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
                                Clipboard.setData(
                                    ClipboardData(text: data['vk']));
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
                            Text("${data['vk']}",
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
