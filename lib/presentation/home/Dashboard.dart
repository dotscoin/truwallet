import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:truwallet/presentation/transaction/Receive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:dio/dio.dart';
import 'package:truwallet/presentation/transaction/send.dart';

class DashBoard extends StatefulWidget {
  // List<double> graph_data = [];
  // var balance;
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<double> graph_data = [];
  var balance;
  String address;
  final storage = new FlutterSecureStorage();
  void getaddress() async {
    address = await storage.read(key: 'address');
  }

  void fetchbalance() async {
    getaddress();
    try {
      Response response = await Dio().post("http://34.68.253.117:8000/",
          data: {"command": "getaddressbalance", "parameters": "$address"});
      print(response);
      setState(() {
        balance = response.data['balance'];
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

  @override
  void initState() {
    fetchData();
    fetchbalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
            //   child: Image.network(
            //       "http://chart.apis.google.com/chart?cht=qr&chs=150x150&chl=fefgg&chld=H|0"),
            // ),
            SizedBox(height: 50),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("BALANCE",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  balance != null
                      ? Text(
                          "$balance TRU",
                          style: TextStyle(
                            fontSize: 48,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : CircularProgressIndicator(),
                ]),
            SizedBox(height: 30),
            Center(
              child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 80,
                  child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: IconButton(
                                      icon: Icon(Icons.arrow_upward,
                                          color: Colors.white),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SendMoney()));
                                      }),
                                ),
                                Text("Send",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: IconButton(
                                      icon: Icon(Icons.arrow_downward,
                                          color: Colors.white),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReceiveMoney()));
                                      }),
                                ),
                                Text("Receive",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: IconButton(
                                      icon: Icon(Icons.account_balance,
                                          color: Colors.white),
                                      onPressed: null),
                                ),
                                Text("buy",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ])
                        ]),
                  )),
            ),

            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: graph_data.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: 100.0,
                      child: Sparkline(
                        data: graph_data,
                        fillMode: FillMode.below,
                        fillGradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue[800],
                            Colors.blue[200],
                            Colors.blue[100],
                            Colors.blue[50],
                            Colors.white
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
}
