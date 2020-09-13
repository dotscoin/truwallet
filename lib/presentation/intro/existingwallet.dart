import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExistingWallet extends StatefulWidget {
  @override
  _ExistingWalletState createState() => _ExistingWalletState();
}

class _ExistingWalletState extends State<ExistingWallet> {
  TextEditingController _addresscontroller = new TextEditingController();
  TextEditingController _skcontroller = new TextEditingController();
  TextEditingController _vkcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text("DOTSWALLET",
              style: TextStyle(color: Colors.blue, letterSpacing: 1.5)),
          backgroundColor: Colors.white),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: Text(
                            "Paste",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
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
                      TextField(
                          controller: _addresscontroller,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'address',
                            // Added this
                            contentPadding: EdgeInsets.all(8),
                          ))
                    ]),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Signing Key",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: Text(
                            "Paste",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
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
                      TextField(
                          controller: _skcontroller,
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'signing key',
                            // Added this
                            contentPadding: EdgeInsets.all(8),
                          ))
                    ]),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Verifying Key",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: Text(
                            "Paste",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    ]),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                          controller: _vkcontroller,
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'verifying Key',
                            // Added this
                            contentPadding: EdgeInsets.all(8),
                          ))
                    ]),
              ),
              SizedBox(height: 25),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: Center(
                        child: Text(" Import ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      )),
                ),
              ),
              SizedBox(height: 25),
            ]),
      )),
    );
  }
}
