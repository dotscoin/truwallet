import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class SecurityScreen extends StatefulWidget {
  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool isSwitched;
  bool loader;
  final LocalAuthentication auth = LocalAuthentication();
  bool hasbiometrics;
  List<BiometricType> availableBiometrics;
  checkAuthentication() async {
    final storage = new FlutterSecureStorage();
    String status = await storage.read(key: 'touchid');
    if (status == 'true') {
      setState(() {
        isSwitched = true;
        loader = false;
      });
    } else {
      setState(() {
        isSwitched = false;
        loader = false;
      });
    }
  }

  changeAuthentication() async {
    final storage = new FlutterSecureStorage();
    if (!isSwitched) {
      await storage.delete(key: 'touchid');
      await storage.write(key: 'touchid', value: 'true');
    } else {
      await storage.delete(key: 'touchid');
      await storage.write(key: 'touchid', value: 'false');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader = true;
    checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Security", style: TextStyle(color: Colors.black))),
      body: loader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Enable Touch ID for App"),
                    trailing: Switch(
                      value: isSwitched,
                      onChanged: (value) async {
                        hasbiometrics = await auth.canCheckBiometrics;
                        if (!hasbiometrics) {
                          final snackbar = new SnackBar(
                              content: Text(
                                  "Your Device Doesn't support Biometrics"));
                          Scaffold.of(context).showSnackBar(snackbar);
                        } else {
                          changeAuthentication();
                          setState(() {
                            isSwitched = value;
                          });
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
