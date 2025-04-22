import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:spendwise_companion/notification.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:spendwise_companion/sms_reader.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<List<String>> fetchSuggestions(String userId) async {
  try {
    final response = await http.post(
      Uri.parse("https://backend.weblytechnolab.com/getSuggestions"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId}),
    );

    final data = jsonDecode(response.body);
    debugPrint("🎯 Suggestions Response: $data");

    if (data["status"] == true && data["suggestions"] != null) {
      List suggestions = data["suggestions"];
      return suggestions.map<String>((s) => s.toString()).toList();
    } else {
      debugPrint(
        "❌ Failed to fetch suggestions: ${data['message'] ?? data['error']}",
      );
      return [];
    }
  } catch (e) {
    debugPrint("🚨 Exception while fetching suggestions: $e");
    return [];
  }
}

Future<void> showRepeatedNotifications(List<String> suggestions) async {
  for (int i = 0; i < suggestions.length; i++) {
    await NotificationHelper.showNotification(
      "📢 Recommendation ${i + 1}",
      suggestions[i],
    );

    // Wait between 5–10 seconds randomly
    final delay = Duration(seconds: 5 + (i % 6)); // randomish 5-10s
    await Future.delayed(delay);
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  final SmsReader smsReader = SmsReader();

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..addJavaScriptChannel(
            'FlutterBridge',
            onMessageReceived: (JavaScriptMessage message) async {
              debugPrint("message: $message");
              final userId = message.message;
              debugPrint("✅ Got userId from WebView: $userId");

              final hasSentTransactions = await smsReader
                  .hasAlreadySentTransactions(
                    userId,
                  ); // You'll create this check

              if (!hasSentTransactions) {
                await smsReader.sendTransactionsToBackendIfFirstTime(userId);
              } else {
                debugPrint("📩 Transactions already sent for user $userId");
              }

              List<String> suggestions = await fetchSuggestions(userId);
              debugPrint("✅ Suggestions: $suggestions");

              showRepeatedNotifications(suggestions);
            },
          )
          ..loadRequest(Uri.parse("https://spendwise.weblytechnolab.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
