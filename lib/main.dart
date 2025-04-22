import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spendwise_companion/notification.dart';
import 'package:spendwise_companion/webview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request notification permission
  await NotificationHelper.init();
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  // Request SMS permission
  var permissionStatus = await Permission.sms.status;
  if (!permissionStatus.isGranted) {
    permissionStatus = await Permission.sms.request();
  }

  if (!permissionStatus.isGranted) {
    throw Exception('SMS Permission denied');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebViewScreen(),
    );
  }
}
