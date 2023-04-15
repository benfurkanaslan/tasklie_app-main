import 'package:encrypt/encrypt.dart';

class EncryptData {
  static encryptAES(plainText) {
    final key = Key.fromUtf8('+C&F)J@NcRfUjXnZr4u7x!A%D*G-KaPd');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static decryptAES(plainText) {
    final key = Key.fromUtf8('+C&F)J@NcRfUjXnZr4u7x!A%D*G-KaPd');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    Encrypted encrypted = Encrypted.fromBase64(plainText);
    String decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
