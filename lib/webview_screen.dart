import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:spendwise_companion/sms_reader.dart';

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
              debugPrint("✅ Got userId from WebView: $userId");

              // Call SMS logic here
              await smsReader.sendTransactionsToBackendIfFirstTime(userId);

              // Send userId to PythonAnywhere backend
              final response = await http.post(
                Uri.parse(
                  'https://backend.weblytechnolab.com/getMonthlyBudget',
                ),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({'user_id': userId}),
              );

              debugPrint("getMonthlyBudget response: $response");

              if (response.statusCode == 200) {
                final data = jsonDecode(response.body);
                debugPrint("📊 Monthly Budget Data: $data");
                // You can store this or use setState to display
              } else {
                debugPrint(
                  "❌ Failed to fetch budget: ${response.statusCode} ${response.body}",
                );
              }
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
