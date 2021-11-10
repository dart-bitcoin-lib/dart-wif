import 'dart:typed_data';

/// WIF
class WIF {
  /// Version
  int version;

  /// Private Key
  Uint8List privateKey;

  /// Is Compressed WIF ?
  bool compressed;

  WIF(
      {required this.version,
      required this.privateKey,
      this.compressed = false});

  /// equal operator
  @override
  bool operator ==(covariant WIF other) {
    return (version == other.version &&
        privateKey.map((e) => e.toRadixString(16).padLeft(2, '0')).join('') ==
            privateKey
                .map((e) => e.toRadixString(16).padLeft(2, '0'))
                .join('') &&
        compressed == other.compressed);
  }

  /// Hash code
  @override
  int get hashCode => Object.hashAll([version, privateKey, compressed]);

  /// To String
  @override
  String toString() {
    List<String> str = [
      '"version": "$version"',
      '"privateKey": "${privateKey.map((e) => e.toRadixString(16).padLeft(2, '0')).join('')}"',
      '"compressed": ${compressed.toString()}'
    ];

    return "{${str.join(",")}}";
  }
}
