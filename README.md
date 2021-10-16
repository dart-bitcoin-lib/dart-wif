# DART WIF

Bitcoin Wallet Import Format encoding/decoding module.

## Example

``` dart
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_wif/dart_wif.dart';

void main() {
  Uint8List privateKey = Uint8List.fromList(hex.decode('0000000000000000000000000000000000000000000000000000000000000001'));
  String key = Wif(version: 128, privateKey:privateKey, compressed: true).encode(); // for the testnet use: Wif.encode(239, ...
  print(key);
  // => KwDiBf89QgGbjEhKnhXJuH7LrciVrZi3qYjgd9M7rFU73sVHnoWn

  var obj = Wif.decode(key);

  print(obj);
  // => {
  //	version: 128,
  //	privateKey: "0000000000000000000000000000000000000000000000000000000000000001",
  //	compressed: true
  //}

   Wif.decode(key, 0x09);
  // => Error: Invalid network version

}
```

## LICENSE [MIT](LICENSE)