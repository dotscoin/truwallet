import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cryptography/cryptography.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:truwallet/presentation/transaction/txstatus.dart';

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
  var cameraScanResult;
  var address;
  var sk;
  var vk;
  final storage = new FlutterSecureStorage();
  var total = 0;
  void getaddress() async {
    address = await storage.read(key: 'address');
    sk = await storage.read(key: 'sk');
    vk = await storage.read(key: 'vk');
    setState(() {
      address = address;
      sk = sk;
      vk = vk;
    });
  }

  var transaction;
  List inputs;

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

  sentransaction() async {
    Response active_nodes =
        await Dio().get("http://dns.dotscoin.com/get_nodes");
    for (var i = 0; i < active_nodes.data['nodes'].length; i++) {
      var node = active_nodes.data['nodes'][i]['ip_addr'];
      try {
        Response utxos = await Dio().post("http://${node}:8000",
            data: {"command": "getallutxobyaddress", "parameters": "$address"});
        var txs = utxos.data['utxos'];
        for (var i = 0; i < txs.length; i++) {
          total += txs[i]['amount'];
          if (total > int.parse(_amountcontroller.text)) {
            break;
          }
          try {
            Response scriptsig = await Dio().post("http://${node}:8000", data: {
              "signing_key": sk,
              "message": {
                "previous_tx": {
                  "previous_tx": txs[i]['tx'],
                  'index': txs[i]['index']
                }
              }
            });
            inputs.add({
              "previous_tx": txs[i]['tx'],
              "index": txs[i]['index'],
              "scriptSig": [scriptsig.data['scriptSig']],
              "address": address,
              "verifying_key": vk
            });
          } on Exception {
            print("transaction signing failed");
          }

          List<int> bytes = utf8.encode(txs);
          txs['hash'] = sha256.hash(bytes);
        }
        break;
      } on Exception {
        continue;
      }
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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TransactionStatus()));
          },
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
