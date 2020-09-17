import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:truwallet/presentation/home/HomeScreen.dart';
import 'package:truwallet/presentation/intro/introscreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool hasbiometrics;
  List<BiometricType> availableBiometrics;
  String authsetting;
  bool authenticated = false;
  apploader() async {
    final storage = new FlutterSecureStorage();
    authsetting = await storage.read(key: 'touchid');
    print(authsetting);
    if (authsetting == null || authsetting == 'false') {
      checkifuser();
    } else {
      authenticate();
    }
  }

  checkifuser() async {
    final storage = new FlutterSecureStorage();
    var address = await storage.read(key: 'address');
    if (address != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }

  authenticate() async {
    final storage = new FlutterSecureStorage();
    String settings = await storage.read(key: 'touchid');
    if (settings == 'false') {
      MaterialPageRoute(builder: (context) => IntroScreen());
    }
    print("signing");
    try {
      print("trying");
      while (!authenticated) {
        authenticated = await auth.authenticateWithBiometrics(
            localizedReason: 'Touch your finger on the sensor to login',
            useErrorDialogs: true,
            stickyAuth: false,
            androidAuthStrings:
                AndroidAuthMessages(signInTitle: "Login to Continue"));
      }
      if (authenticated) {
        print("hello");
        checkifuser();
      }
    } catch (e) {
      print("error using biometric auth: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apploader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
