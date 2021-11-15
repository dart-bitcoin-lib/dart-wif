import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58check/dart_bs58check.dart';
import 'package:dart_wif/dart_wif.dart';

/// The canonical instance of [WIFEncoder].
const wifDecoder = WIFDecoder();

/// The canonical instance of [WIFDecoder].
class WIFDecoder extends Converter<String, WIF> {
  const WIFDecoder();

  /// Convert [String] to [WIF]
  @override
  WIF convert(String input, [int? version]) {
    Uint8List buffer = bs58check.decode(input);
    if (version != null && buffer[0] != version) {
      throw ArgumentError('Invalid network version');
    }

    // uncompressed
    if (buffer.lengthInBytes == 33) {
      return WIF(
          version: buffer[0], privateKey: buffer.sublist(1), compressed: false);
    }

    // invalid length
    if (buffer.length != 34) {
      throw ArgumentError('Invalid WIF length');
    }

    // invalid compression flag
    if (buffer[33] != 0x01) {
      throw ArgumentError('Invalid compression flag');
    }

    // compressed
    return WIF(
        version: buffer[0],
        privateKey: buffer.sublist(1, 33),
        compressed: true);
  }
}
