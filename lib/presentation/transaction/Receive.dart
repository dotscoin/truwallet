import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class ReceiveMoney extends StatefulWidget {
  @override
  _ReceiveMoneyState createState() => _ReceiveMoneyState();
}

class _ReceiveMoneyState extends State<ReceiveMoney> {
  var query = "";
  var amount = "";
  TextEditingController _amountcontroller = new TextEditingController();
  getaddress() async {
    final storage = new FlutterSecureStorage();
    var temp = await storage.read(key: 'address');
    setState(() {
      query = temp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaddress();
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
        body: query != ""
            ? Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey[400], blurRadius: 20)
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Address",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  letterSpacing: 1.5)),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: QrImage(
                            data: query,
                            version: QrVersions.auto,
                            size: 250,
                          )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(query,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue,
                                  letterSpacing: 1)),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: IconButton(
                                    icon: Icon(Icons.content_copy,
                                        color: Colors.white),
                                    onPressed: () {
                                      Clipboard.setData(
                                          ClipboardData(text: query));
                                    }),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Copy",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: IconButton(
                                    icon: Icon(Icons.payment,
                                        color: Colors.white),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Set Amount"),
                                              content: TextField(
                                                controller: _amountcontroller,
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Cancel")),
                                                FlatButton(
                                                  child: Text("Set",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  onPressed: () {
                                                    setState(() {
                                                      amount = _amountcontroller
                                                          .text;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  color: Colors.blue,
                                                )
                                              ],
                                            );
                                          });
                                    }),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Amount",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: IconButton(
                                    icon:
                                        Icon(Icons.share, color: Colors.white),
                                    onPressed: () {
                                      String text =
                                          "Use Truwallet to Pay via through this Link:  https://pay.trucoin.org?address=${query}&amount=${amount}";
                                      String sub =
                                          "Use Truwallet to Pay via through this Link";
                                      final RenderBox box =
                                          context.findRenderObject();
                                      Share.share(text,
                                          subject: sub,
                                          sharePositionOrigin:
                                              box.localToGlobal(Offset.zero) &
                                                  box.size);
                                    }),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Share",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]),
                      ],
                    )
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10.0, right: 5),
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: <Widget>[
                    //         Text("Address",
                    //             style: TextStyle(
                    //                 fontSize: 30,
                    //                 color: Colors.blue,
                    //                 fontWeight: FontWeight.bold,
                    //                 letterSpacing: 1.2)),
                    //         IconButton(
                    //           icon: Icon(Icons.content_copy),
                    //           onPressed: () {
                    //             Clipboard.setData(ClipboardData(text: "hello"));
                    //           },
                    //         )
                    //       ]),
                    // ),
                    // SizedBox(height: 5),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10.0),
                    //   child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: <Widget>[
                    //         Text(
                    //           "sdsdsssdsdsgergedfgfdg",
                    //           style: TextStyle(
                    //             fontSize: 18,
                    //             color: Colors.black,
                    //           ),
                    //           textAlign: TextAlign.left,
                    //         ),
                    //       ]),
                    // ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
