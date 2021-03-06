import 'dart:typed_data';

import 'package:convert/convert.dart';

enum FixtureEnum { valid, invalidEncode, invalidDecode }

class Fixture {
  String? wif;

  bool? compressed;

  Uint8List? get privateKey {
    if (privateKeyHex != null) {
      return Uint8List.fromList(hex.decode(privateKeyHex!));
    }
  }

  String? privateKeyHex;

  int? version;

  String? exception;

  Fixture(
      {this.wif,
      this.exception,
      this.compressed,
      this.privateKeyHex,
      this.version});
}

Map<FixtureEnum, List<Fixture>> fixtures = {
  FixtureEnum.valid: [
    Fixture(
        wif: "KwDiBf89QgGbjEhKnhXJuH7LrciVrZi3qYjgd9M7rFU73sVHnoWn",
        compressed: true,
        privateKeyHex:
            "0000000000000000000000000000000000000000000000000000000000000001",
        version: 128),
    Fixture(
        wif: "5HpHagT65TZzG1PH3CSu63k8DbpvD8s5ip4nEB3kEsreAnchuDf",
        compressed: false,
        privateKeyHex:
            "0000000000000000000000000000000000000000000000000000000000000001",
        version: 128),
    Fixture(
        wif: "KxhEDBQyyEFymvfJD96q8stMbJMbZUb6D1PmXqBWZDU2WvbvVs9o",
        compressed: true,
        privateKeyHex:
            "2bfe58ab6d9fd575bdc3a624e4825dd2b375d64ac033fbc46ea79dbab4f69a3e",
        version: 128),
    Fixture(
        wif: "KzrA86mCVMGWnLGBQu9yzQa32qbxb5dvSK4XhyjjGAWSBKYX4rHx",
        compressed: true,
        privateKeyHex:
            "6c4313b03f2e7324d75e642f0ab81b734b724e13fec930f309e222470236d66b",
        version: 128),
    Fixture(
        wif: "5JdxzLtFPHNe7CAL8EBC6krdFv9pwPoRo4e3syMZEQT9srmK8hh",
        compressed: false,
        privateKeyHex:
            "6c4313b03f2e7324d75e642f0ab81b734b724e13fec930f309e222470236d66b",
        version: 128),
    Fixture(
        wif: "cRD9b1m3vQxmwmjSoJy7Mj56f4uNFXjcWMCzpQCEmHASS4edEwXv",
        compressed: true,
        privateKeyHex:
            "6c4313b03f2e7324d75e642f0ab81b734b724e13fec930f309e222470236d66b",
        version: 239),
    Fixture(
        wif: "92Qba5hnyWSn5Ffcka56yMQauaWY6ZLd91Vzxbi4a9CCetaHtYj",
        compressed: false,
        privateKeyHex:
            "6c4313b03f2e7324d75e642f0ab81b734b724e13fec930f309e222470236d66b",
        version: 239),
    Fixture(
        wif: "L5oLkpV3aqBjhki6LmvChTCV6odsp4SXM6FfU2Gppt5kFLaHLuZ9",
        compressed: true,
        privateKeyHex:
            "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364140",
        version: 128)
  ],
  FixtureEnum.invalidEncode: [
    Fixture(
        exception: "Invalid privateKey length",
        version: 128,
        privateKeyHex: "fffffffffffeba")
  ],
  FixtureEnum.invalidDecode: [
    Fixture(
        exception: "Invalid network version",
        version: 128,
        wif: "92Qba5hnyWSn5Ffcka56yMQauaWY6ZLd91Vzxbi4a9CCetaHtYj"),
    Fixture(
        exception: "Invalid compression flag",
        version: 128,
        wif: "KwDiBf89QgGbjEhKnhXJuH7LrciVrZi3qYjgd9M7rFU73sfZr2ym"),
    Fixture(
        exception: "Invalid WIF length",
        version: 128,
        wif: "3tq8Vmhh9SN5XhjTGSWgx8iKk59XbKG6UH4oqpejRuJhfYD"),
    Fixture(
        exception: "Invalid WIF length",
        version: 128,
        wif: "38uMpGARR2BJy5p4dNFKYg9UsWNoBtkpbdrXDjmfvz8krCtw3T1W92ZDSR")
  ]
};
