import 'dart:typed_data';

import 'package:pointycastle/asn1.dart';

///
///```
/// EncryptedData ::= SEQUENCE {
///   version Version,
///   encryptedContentInfo EncryptedContentInfo
/// }
///```
///
class EncryptedData extends ASN1Object {
  ASN1Integer version = ASN1Integer.fromtInt(0);
  late EncryptedContentInfo encryptedContentInfo;

  EncryptedData(this.encryptedContentInfo);

  EncryptedData.fromSequence(ASN1Sequence seq) {
    version = seq.elements!.elementAt(0) as ASN1Integer;
    if (seq.elements!.length >= 2) {
      var el = seq.elements!.elementAt(1);
      if (el is ASN1Sequence) {
        encryptedContentInfo = EncryptedContentInfo.fromSequence(el);
      }
    }
  }

  @override
  Uint8List encode(
      {ASN1EncodingRule encodingRule = ASN1EncodingRule.ENCODING_DER}) {
    var tmp = ASN1Sequence(elements: [
      version,
      encryptedContentInfo,
    ]);
    return tmp.encode(encodingRule: encodingRule);
  }
}
