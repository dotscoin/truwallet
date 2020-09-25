import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReceiveMoney extends StatefulWidget {
  @override
  _ReceiveMoneyState createState() => _ReceiveMoneyState();
}

class _ReceiveMoneyState extends State<ReceiveMoney> {
  Image qr;
  var query = "";
  getaddress() async {
    final storage = new FlutterSecureStorage();
    var temp = await storage.read(key: 'address');
    setState(() {
      query = temp;
      qr = Image.network(
          "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=${query}");
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
        body: query != "" && qr != null
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
                          Text("Address",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  letterSpacing: 1.5)),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: qr,
                          ),
                          SizedBox(
                            height: 35,
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
                                    onPressed: () {}),
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
                                    icon:
                                        Icon(Icons.share, color: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReceiveMoney()));
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
