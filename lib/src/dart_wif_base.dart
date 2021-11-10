import 'dart:convert';

import 'package:dart_wif/dart_wif.dart';

/// The canonical instance of [WIFCodec].
const wif = WIFCodec();

/// WIF Codec
///
/// Decodes/Encodes for [WIF] and [String]
class WIFCodec extends Codec<WIF, String> {
  const WIFCodec();

  @override
  WIFDecoder get decoder => wifDecoder;

  @override
  WIFEncoder get encoder => wifEncoder;

  /// Decodes [encoded] data.
  ///
  /// The input is decoded as if by `decoder.convert`.
  @override
  WIF decode(String encoded, [int? version]) {
    return wifDecoder.convert(encoded, version);
  }
}
