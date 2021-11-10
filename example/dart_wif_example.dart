import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_wif/dart_wif.dart';

void main() {
  Uint8List privateKey = Uint8List.fromList(hex.decode(
      '0000000000000000000000000000000000000000000000000000000000000001'));
  final WIF decoded =
      WIF(version: 128, privateKey: privateKey, compressed: true);
  String key = wif.encode(decoded); // for the testnet use: Wif.encode(239, ...
  print(key);
  // => KwDiBf89QgGbjEhKnhXJuH7LrciVrZi3qYjgd9M7rFU73sVHnoWn

  var obj = wif.decode(key);

  print(obj);
  // => {
  //	version: 128,
  //	privateKey: "0000000000000000000000000000000000000000000000000000000000000001",
  //	compressed: true
  //}

  try {
    wif.decode(key, 0x09);
  } catch (e) {
    print(e);
  }
  // => Invalid argument(s): Invalid network version

  print(obj == decoded);
  // => true

  print(obj == WIF(privateKey: Uint8List(0), version: 1, compressed: false));
  // => false
}
