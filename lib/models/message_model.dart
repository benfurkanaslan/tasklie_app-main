import 'package:cloud_firestore/cloud_firestore.dart';

/// [MessageModel] sınıfı veritabanında tutulan mesajların modelidir.
///
/// [senderEmail] mesajı gönderen kullanıcının emailidir.
///
/// [senderName] mesajı gönderen kullanıcının adıdır.
///
/// [time] mesajın gönderildiği zamanı temsil eder.
///
/// [text] mesajın içeriğidir, şifrelenmiş olarak tutulur.

class MessageModel {
  final String senderEmail;
  final String senderName;
  final Timestamp time;
  final String text;

  MessageModel({
    required this.senderEmail,
    required this.senderName,
    required this.time,
    required this.text,
  });

  @override
  String toString() {
    return '{senderEmail: $senderEmail, senderName: $senderName time: $time, text: $text}';
  }
}
