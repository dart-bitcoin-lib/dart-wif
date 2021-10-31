import 'package:convert/convert.dart';
import 'package:dart_wif/dart_wif.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  if (fixtures.containsKey(FixtureEnum.valid)) {
    for (Fixture fixture in fixtures[FixtureEnum.valid]!) {
      test(
          'encode/encodeRaw returns ${fixture.wif!} for ${fixture.privateKeyHex!.substring(0, 20)}... (${fixture.version!.toString()})',
          () {
        String actual = Wif(
                version: fixture.version!,
                privateKey: fixture.privateKey!,
                compressed: fixture.compressed!)
            .encode();
        expect(actual, equals(fixture.wif));
      });
      test(
          'decode/decodeRaw returns ${fixture.privateKeyHex!.substring(0, 20)}... (${fixture.version!}) for ${fixture.wif!}',
          () {
        Wif actual = Wif.decode(fixture.wif!, fixture.version);
        expect(actual.version, equals(fixture.version));
        expect(hex.encode(actual.privateKey), equals(fixture.privateKeyHex));
        expect(actual.compressed, equals(fixture.compressed));
      });

      test('decode/encode for ${fixture.wif}', () {
        Wif actual = Wif.decode(
            Wif(
                    version: fixture.version!,
                    privateKey: fixture.privateKey!,
                    compressed: fixture.compressed!)
                .encode(),
            fixture.version);

        expect(actual, equals(actual));
      });
    }
  }
  if (fixtures.containsKey(FixtureEnum.invalidDecode)) {
    for (Fixture fixture in fixtures[FixtureEnum.invalidDecode]!) {
      test("throws ${fixture.exception} for ${fixture.wif}", () {
        Wif? buffer;
        try {
          buffer = Wif.decode(fixture.wif!, fixture.version);
        } catch (err) {
          expect((err as ArgumentError).message, fixture.exception);
        } finally {
          expect(buffer, null);
        }
      });
    }
  }
  if (fixtures.containsKey(FixtureEnum.invalidEncode)) {
    for (Fixture fixture in fixtures[FixtureEnum.invalidEncode]!) {
      test("throws ${fixture.exception} for ${fixture.privateKeyHex}", () {
        String? buffer;
        try {
          buffer =
              Wif(privateKey: fixture.privateKey!, version: fixture.version!)
                  .encode();
        } catch (err) {
          expect((err as ArgumentError).message, fixture.exception);
        } finally {
          expect(buffer, null);
        }
      });
    }
  }
}
