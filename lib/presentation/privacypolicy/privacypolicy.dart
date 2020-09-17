import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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
    );
  }
}
