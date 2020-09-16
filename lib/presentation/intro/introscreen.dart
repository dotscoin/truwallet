import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:truwallet/presentation/intro/existingwallet.dart';
import 'package:truwallet/presentation/intro/showkeygen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  checkifuser() async {
    final storage = new FlutterSecureStorage();
    var address = await storage.read(key: 'address');
    if (address != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkifuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TRUWALLET",
              style: TextStyle(color: Colors.blue, letterSpacing: 1.5)),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ),
        body: Column(children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: PageView(children: <Widget>[
                Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 35),
                          Image.asset("assets/atm.png", height: 200),
                          SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Withdraw money at any time",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Funds will never be blocked by this decentralized blockchain.",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ])),
                Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 35),
                          Image.asset("assets/banking.png", height: 200),
                          SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Withdraw money at any time",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Funds will never be blocked by this decentralized blockchain.",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ])),
                Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 35),
                          Image.asset("assets/atm.png", height: 200),
                          SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Withdraw money at any time",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Funds will never be blocked by this decentralized blockchain.",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]))
              ])),
          SizedBox(height: 25),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ShowKeygenScreen()));
            },
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                child: Center(
                  child: Text("Create a new Wallet",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                )),
          ),
          SizedBox(height: 25),
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ExistingWallet()));
              },
              child: Center(
                  child: Text("I Already Have a Wallet",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))))
        ]));
  }
}
