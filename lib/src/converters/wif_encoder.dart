import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58check/dart_bs58check.dart';
import 'package:dart_wif/dart_wif.dart';

/// The canonical instance of [WIFEncoder].
const wifEncoder = WIFEncoder();

/// Encode [WIF] to [String]
class WIFEncoder extends Converter<WIF, String> {
  const WIFEncoder();

  /// Convert [WIF] to [String]
  @override
  String convert(WIF input) {
    if (input.privateKey.length != 32) {
      throw ArgumentError('Invalid privateKey length');
    }

    Uint8List result = Uint8List(input.compressed ? 34 : 33);
    result[0] = input.version;
    result.setRange(1, 33, input.privateKey);

    // if is compressed, add compressed flag
    if (input.compressed) {
      result[33] = 0x01;
    }

    return bs58check.encode(result);
  }
}
