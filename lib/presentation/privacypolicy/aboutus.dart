import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("TRUWALLET",
              style: TextStyle(color: Colors.blue, letterSpacing: 1.5)),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
            child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/ic_launcher.png")),
            ]),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Developed By: Triunits",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("version no: 1.0.1",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))
            ])
          ],
        )));
  }
}
