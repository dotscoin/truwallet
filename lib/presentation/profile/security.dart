import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Security", style: TextStyle(color: Colors.black))),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("Enable Touch ID for App"),
              trailing: Text("hello"),
            ),
          )
        ],
      ),
    );
  }
}
