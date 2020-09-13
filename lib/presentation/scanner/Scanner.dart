import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ScanAndPay extends StatefulWidget {
  final address;
  ScanAndPay({Key key, this.address}) : super(key: key);

  @override
  _ScanAndPayState createState() => _ScanAndPayState();
}

class _ScanAndPayState extends State<ScanAndPay> {
  TextEditingController _controller = new TextEditingController();
  String _address;
  var cameraScanResult;
  bool paymentloading = true;
  scan() async {
    var cameraScanResult = await BarcodeScanner.scan();
    if (cameraScanResult.rawContent == "") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
    print(cameraScanResult);
    print(
        cameraScanResult.type); // The result type (barcode, cancelled, failed)
    print(cameraScanResult.rawContent); // The barcode content
    print(cameraScanResult.format); // The barcode format (as enum)
    print(cameraScanResult.formatNote);
    // If a unknown format was scanned this field contains a note
    if (cameraScanResult.rawContent != "") {
      setState(() {
        paymentloading = false;
      });
    }
  }

  @override
  initState() {
    super.initState();
    paymentloading = true;
    //scan();
    _address = widget.address;
    paymentloading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue, elevation: 0),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ),
        body: paymentloading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(children: <Widget>[
                        SizedBox(height: 50),
                        Text("Sending To Address",
                            style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 35,
                                letterSpacing: 1.2)),
                        SizedBox(height: 30),
                        Text("${_address}",
                            style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 25,
                                letterSpacing: 1.2)),
                        SizedBox(height: 30),
                        Container(
                            width: 200,
                            child: TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Amount",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ))),
                        SizedBox(height: 10),
                      ]),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    )),
              ));
  }
}
