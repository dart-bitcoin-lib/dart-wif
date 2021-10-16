import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_bs58check/dart_bs58check.dart' as bs58check;

/// Bitcoin Wallet Import Format encoding/decoding module.
class Wif {
  int version;
  Uint8List privateKey;
  bool compressed;

  Wif(
      {required this.version,
      required this.privateKey,
      this.compressed = false});

  /// Decode Wif from Uint8List
  factory Wif.decodeRaw(Uint8List buffer, [int? version]) {
    if (version != null && buffer[0] != version) {
      throw ArgumentError('Invalid network version');
    }

    // uncompressed
    if (buffer.lengthInBytes == 33) {
      return Wif(
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
    return Wif(
        version: buffer[0],
        privateKey: buffer.sublist(1, 33),
        compressed: true);
  }

  /// Encode Wif to Uint8List
  Uint8List encodeRaw() {
    if (privateKey.length != 32) {
      throw ArgumentError('Invalid privateKey length');
    }

    ByteData result = ByteData(compressed ? 34 : 33);
    result.setUint8(0, version);

    final privateKeyByteData = privateKey.buffer.asByteData();

    for (int i = 0; i < privateKeyByteData.lengthInBytes; i++) {
      result.setUint8(i + 1, privateKeyByteData.getUint8(i));
    }

    // if is compressed, add compressed flag
    if (compressed) {
      result.setUint8(33, 0x01);
    }

    return Uint8List.view(result.buffer);
  }

  /// Decode Wif from String
  factory Wif.decode(String string, [int? version]) {
    return Wif.decodeRaw(bs58check.decode(string), version);
  }

  /// Encode Wif to String
  String encode() {
    return bs58check.encode(encodeRaw());
  }

  @override
  bool operator ==(covariant Wif other) {
    return (version == other.version &&
        hex.encode(privateKey) == hex.encode(other.privateKey) &&
        compressed == other.compressed);
  }

  @override
  int get hashCode => Object.hashAll([version, privateKey, compressed]);

  @override
  String toString() {
    List<String> str = [
      '"version": "$version"',
      '"privateKey": "${hex.encode(privateKey)}"',
      '"compressed": ${compressed.toString()}'
    ];

    return "{${str.join(",")}}";
  }
}
