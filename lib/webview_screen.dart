import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spendwise_companion/notification.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:spendwise_companion/sms_reader.dart';

class Recommendation {
  final String title;
  final String body;

  Recommendation({required this.title, required this.body});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(title: json['title'] ?? '', body: json['body'] ?? '');
  }
}

Future<List<Recommendation>> fetchSuggestions(String userId) async {
  try {
    final response = await http.post(
      Uri.parse("https://backend.weblytechnolab.com/getSuggestions"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId}),
    );

    final data = jsonDecode(response.body);
    debugPrint("🎯 Suggestions Response: $data");

    if (data["status"] == true && data["recommendations"] != null) {
      List recs = data["recommendations"];
      return recs
          .map<Recommendation>((r) => Recommendation.fromJson(r))
          .toList();
    } else {
      debugPrint(
        "❌ Failed to fetch recommendations: ${data['message'] ?? 'Unknown error'}",
      );
      return [];
    }
  } catch (e) {
    debugPrint("🚨 Exception while fetching suggestions: $e");
    return [];
  }
}

Future<void> showRepeatedNotifications(List<Recommendation> suggestions) async {
  for (int i = 0; i < suggestions.length; i++) {
    final rec = suggestions[i];

    await NotificationHelper.showNotification(rec.title, rec.body);

    // Add a natural delay between 5–10 seconds (using modulo as a light randomizer)
    final delay = Duration(seconds: 5 + (i % 6));
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
              final userId = message.message;

              final hasSentTransactions = await smsReader
                  .hasAlreadySentTransactions(
                    userId,
                  ); // You'll create this check

              if (!hasSentTransactions) {
                await smsReader.sendTransactionsToBackendIfFirstTime(userId);
              } else {
                debugPrint("📩 Transactions already sent for user $userId");
              }

              List<Recommendation> suggestions = await fetchSuggestions(userId);
              for (var rec in suggestions) {
                debugPrint("🔔 ${rec.title}: ${rec.body}");
              }
              await showRepeatedNotifications(suggestions);
            },
          )
          // ..loadRequest(Uri.parse("https://spendwise.weblytechnolab.com/"));
          ..loadRequest(
            Uri.parse(
              "https://7f67-2401-4900-91fa-ddef-f105-8c1a-6252-4e17.ngrok-free.app/",
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
