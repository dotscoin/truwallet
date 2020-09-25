import 'package:flutter/material.dart';
import 'package:truwallet/presentation/home/HomeScreen.dart';

class TransactionStatus extends StatefulWidget {
  @override
  _TransactionStatusState createState() => _TransactionStatusState();
}

class _TransactionStatusState extends State<TransactionStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        backgroundColor: Colors.blue,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Transaction Sent",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              },
              color: Colors.white,
              child: Text("Home"),
            )
          ],
        )));
  }
}
