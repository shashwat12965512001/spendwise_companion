import 'package:flutter/material.dart';
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
