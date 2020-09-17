import 'package:barcode_scan/barcode_scan.dart';
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SendMoney(address: cameraScanResult.rawContent)));
    }
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
                  ListTile(
                      leading: CircleAvatar(
                          child: Icon(Icons.arrow_downward),
                          backgroundColor: Colors.green),
                      title: Text("asfheaufehfuewrewyfrhefef"),
                      subtitle: Text("2300.03 tru"),
                      trailing:
                          FlatButton(child: Text("Pay"), onPressed: () => {})),
                  ListTile(
                      leading: CircleAvatar(
                          child: Icon(Icons.arrow_upward),
                          backgroundColor: Colors.red),
                      title: Text("asfheaufehfuewrewyfrhefef"),
                      subtitle: Text("300.03 tru"),
                      trailing:
                          FlatButton(child: Text("Pay"), onPressed: () => {})),
                ],
              ),
            ),
          ],
        ));
  }
}
