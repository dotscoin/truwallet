import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReceiveMoney extends StatefulWidget {
  @override
  _ReceiveMoneyState createState() => _ReceiveMoneyState();
}

class _ReceiveMoneyState extends State<ReceiveMoney> {
  var query = "address";
  var url =
      'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=sdsds';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("DOTSWALLET",
            style: TextStyle(color: Colors.blue, letterSpacing: 1.5)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.network(url),
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
                        Clipboard.setData(ClipboardData(text: "hello"));
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
                      "sdsdsssdsdsgergedfgfdg",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
