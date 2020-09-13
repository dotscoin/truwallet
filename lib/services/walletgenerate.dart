import 'package:cryptography/cryptography.dart';
import 'package:flutter/services.dart';

class GenerateWallet {
  var address;
  var vk;
  var sk;

  GenerateWallet({this.address, this.vk, this.sk});

  Future<GenerateWallet> generate() async {
    const platform = const MethodChannel('dotswallet/address');
    try {
      final Map result = await platform.invokeMethod('getAddress');
    } catch (error) {
      throw error;
    }
  }
}
