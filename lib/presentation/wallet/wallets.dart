import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:truwallet/presentation/intro/introscreen.dart';

class WalletsScreen extends StatefulWidget {
  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  bool loader;
  var addresses = [];
  var vk = [];
  var sk = [];
  var activeaddress;
  getwallets() async {
    final storage = new FlutterSecureStorage();
    var n = await storage.read(key: 'n');
    if (n != null) {
      int index = int.parse(n);
      for (var i = 0; i <= index; i++) {
        addresses.add(await storage.read(key: "address$i"));
        vk.add(await storage.read(key: "vk$i"));
        sk.add(await storage.read(key: "sk$i"));
      }
      activeaddress = await storage.read(key: 'address');
      setState(() {
        loader = false;
      });
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }

  deletewallet(int index) async {
    final storage = new FlutterSecureStorage();
    var n = await storage.read(key: 'n');
    var len = int.parse(n) - 1;
    storage.deleteAll();
    addresses.removeAt(index);
    for (var i = 0; i <= len; i++) {
      await storage.write(key: 'address$i', value: addresses[i]);
      await storage.write(key: 'sk$i', value: sk[i]);
      await storage.write(key: 'vk$i', value: vk[i]);
    }
    await storage.write(key: 'n', value: "$len");
    await storage.write(key: 'address', value: addresses[0]);
    await storage.write(key: 'vk', value: vk[0]);
    await storage.write(key: 'sk', value: sk[0]);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  changewallet(int index) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'address');
    await storage.delete(key: "vk");
    await storage.delete(key: 'sk');
    await storage.write(key: 'address', value: addresses[index]);
    await storage.write(key: 'vk', value: vk[index]);
    await storage.write(key: 'sk', value: sk[index]);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  void initState() {
    loader = true;
    super.initState();
    getwallets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Wallet", style: TextStyle(color: Colors.black)),
        ),
        body: loader
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 15, bottom: 15),
                        child: Text(
                          "Multi Wallets",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: addresses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                changewallet(index);
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.account_balance_wallet,
                                  color: addresses[index] == activeaddress
                                      ? Colors.blue
                                      : Colors.black,
                                ),
                                title: Text("Wallet"),
                                subtitle: Text("${addresses[index]}"),
                                trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Delete Wallet"),
                                            content: Text(
                                                "This will delete the wallet from the device"),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Cancel")),
                                              FlatButton(
                                                child: Text("Delete",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                onPressed: () {
                                                  deletewallet(index);
                                                },
                                                color: Colors.red,
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            );
                          }))
                ],
              ));
  }
}
