import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

class ToolsCrypto {
 static String toMD5(String input) {
    return crypto.md5.convert(utf8.encode(input)).toString();
  }
}
