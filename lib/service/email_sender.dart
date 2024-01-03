import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
class EmailSender {
  final String username;
  final String password;

  EmailSender(this.username, this.password);

  Future<void> sendEmail(String recipient, String subject, String body) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'ECOSHOP')
      ..recipients.add(recipient)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message envoyé: ${sendReport.toString()}');
    } on MailerException catch (e) {
      print('Erreur d\'envoi: $e');
      // Gérer les erreurs d'envoi d'e-mail ici
    }
  }
}
