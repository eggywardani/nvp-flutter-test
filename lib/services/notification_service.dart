import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<String> sendNotification(
      String title, String message, String topic) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAA18f0nsc:APA91bHq0m_WHcx1v_MJilZRnAeyElCmQxwHfMfdMNZJuwZthatCvhYiXZtjCI03_MVPI7tyDBCyWrIgggY10teFx2sOtmgtAtSMOXSOrHoZJws3FfVgZIrxva1UlbbwkOR3cp4cDIP_',
    };

    final body = {
      'to': '/topics/$topic',
      'notification': {
        'title': title,
        'body': message,
      },
      'priority': 'high',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return 'Notification sent successfully!';
      } else {
        return 'Failed to send notification. Status: ${response.statusCode} - Response: ${response.body}';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }
}

class NotificationTopics {
  static const String topic = 'topic';
}
