import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:truwallet/presentation/home/HomeScreen.dart';

class SendMoney extends StatefulWidget {
  final address;
  final amount;
  SendMoney({Key key, this.address, this.amount}) : super(key: key);
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  TextEditingController _addresscontroller = new TextEditingController();
  TextEditingController _amountcontroller = new TextEditingController();
  String _address;
  var cameraScanResult;
  bool paymentloading = false;
  scan() async {
    var cameraScanResult = await BarcodeScanner.scan();
    print(cameraScanResult);
    print(
        cameraScanResult.type); // The result type (barcode, cancelled, failed)
    print(cameraScanResult.rawContent); // The barcode content
    print(cameraScanResult.format); // The barcode format (as enum)
    print(cameraScanResult.formatNote);
    // If a unknown format was scanned this field contains a note
    if (cameraScanResult.rawContent != "") {
      _addresscontroller.text = cameraScanResult.rawContent;
    }
  }

  @override
  initState() {
    super.initState();
    if (widget.address != null) {
      setState(() {
        _addresscontroller.text = widget.address;
      });
    }
    if (widget.address != null) {
      setState(() {
        _amountcontroller.text = widget.amount;
      });
    }
  }

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 50),
            Row(children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextField(
                      controller: _addresscontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusColor: Colors.blue,
                          border: OutlineInputBorder(),
                          hintText: "Address",
                          filled: true,
                          prefixIcon: Icon(Icons.mail_outline),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.center_focus_strong),
                              onPressed: () {
                                scan();
                              })),
                    )),
              )
            ]),
            Row(children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountcontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        hintText: "Amount",
                        filled: true,
                        prefixIcon: Icon(Icons.monetization_on),
                      ),
                    )),
              )
            ]),
          ],
        ));
  }
}
