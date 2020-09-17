import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:truwallet/presentation/home/Dashboard.dart';
import 'package:truwallet/presentation/profile/Profile.dart';
import 'package:truwallet/presentation/scanner/Scanner.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:truwallet/presentation/transaction/send.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var address;
  final storage = new FlutterSecureStorage();
  var host;
  List txs = [];
  List<double> graph_data = [];
  var balance;

  void getaddress() async {
    address = await storage.read(key: 'address');
    setState(() {
      address = address;
    });
  }

  void fetchbalance() async {
    try {
      Response response = await Dio().post("http://34.68.253.117:8000/",
          data: {"command": "getaddressbalance", "parameters": "$address"});
      print(response);
      setState(() {
        balance = response.data['balance'];
        print(balance);
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  void fetchData() async {
    try {
      Response response = await Dio().get(
          "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1d");
      response.data.forEach((dat) => {
            setState(() => {graph_data.add(double.parse(dat[1]))})
          });
    } catch (e) {
      print(e);
    }
  }

  scan() async {
    var cameraScanResult = await BarcodeScanner.scan();
    if (cameraScanResult.rawContent == "") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
    if (cameraScanResult.rawContent != "") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SendMoney(address: cameraScanResult.rawContent)));
    }
  }

  void fetchprevioustransaction() async {
    getaddress();
    Response response = await Dio().post("http://34.68.253.117:8000/", data: {
      "command": "gettxsbyaddress",
      "parameters": "1d3f347aada53547142da8edea5e0019e6ef31bb15"
    });
    for (var i = 0; i < response.data['txs'].length; i++) {
      var transaction = response.data['txs'][i];
      for (var j = 0; j < transaction['outputs'].length; j++) {
        var output = transaction['outputs'][j];
        if (output['address'] != address) {
          setState(() {
            txs.add({
              "type": "send",
              "address": output['address'],
              "value": output['value']
            });
          });
        } else {
          setState(() {
            txs.add({
              "type": "received",
              "address": transaction['inputs'].length != 0
                  ? transaction['inputs'][0]['address']
                  : "mining reward",
              "value": output['value']
            });
          });
        }
      }
    }
    print(txs);
  }

  @override
  void initState() {
    super.initState();
    getaddress();
    fetchprevioustransaction();
    print(balance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("TRUWALLET",
            style: TextStyle(color: Colors.blue, letterSpacing: 1.5)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: Icon(Icons.loop)),
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ));
            },
          )
        ],
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.center_focus_weak),
          onPressed: () {
            scan();
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          DashBoard(),
          SlidingUpPanel(
            minHeight: MediaQuery.of(context).size.height / 3.6,
            maxHeight: MediaQuery.of(context).size.height,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 35,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: txs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: CircleAvatar(
                              child: txs[index]['type'] == 'send'
                                  ? Icon(Icons.arrow_upward)
                                  : Icon(Icons.arrow_upward),
                              backgroundColor: txs[index]['type'] == 'send'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                            title: Text("${txs[index]['address']}"),
                            subtitle: Text("${txs[index]['value']} TRU"),
                            trailing: FlatButton(
                                child: Text("Pay"), onPressed: () => {}));
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
