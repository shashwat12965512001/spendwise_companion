import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsReader {
  Future<List<SmsMessage>> readAllSms() async {
    // Request SMS permission
    var permissionStatus = await Permission.sms.status;

    if (!permissionStatus.isGranted) {
      permissionStatus = await Permission.sms.request();
    }

    if (!permissionStatus.isGranted) {
      throw Exception('SMS Permission denied');
    }

    // Fetch all SMS
    SmsQuery query = SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;
    return messages;
  }

  Future<List<SmsMessage>> getTransactionMessages() async {
    final allMessages = await readAllSms();

    return allMessages.where((msg) {
      final body = msg.body?.toLowerCase() ?? '';
      return body.contains('credit') || body.contains('debit');
    }).toList();
  }

  Future<void> sendTransactionsToBackendIfFirstTime(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    final alreadyFetched = prefs.getBool('smsFetched_$userId') ?? false;

    if (alreadyFetched) {
      debugPrint("✅ SMS already fetched for user $userId. Skipping.");
      return;
    }

    final transactionMessages = await getTransactionMessages();

    final List<Map<String, dynamic>> formattedTransactions =
        transactionMessages.map((msg) {
          return {
            "Address": msg.address,
            "Message": msg.body,
            "Date": msg.date?.toIso8601String(),
          };
        }).toList();

    final uri = Uri.parse(
      'https://ss12965512001.pythonanywhere.com/transactions',
    );

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"transactions": formattedTransactions}),
    );

    if (response.statusCode == 200) {
      debugPrint("✅ Transactions sent successfully for $userId!");
      await prefs.setBool('smsFetched_$userId', true);
    } else {
      debugPrint(
        "❌ Failed to send transactions: ${response.statusCode} ${response.body}",
      );
    }
  }
}
