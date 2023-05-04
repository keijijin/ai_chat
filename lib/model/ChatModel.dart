import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Message.dart';

class ChatModel with ChangeNotifier {
  String apiUrl;
  double temperature;
  int maxTokens;
  List<Message> messages = [];

  ChatModel(
      {required this.apiUrl,
      required this.temperature,
      required this.maxTokens});

  void updateSettings({
    required String apiUrl,
    required double temperature,
    required int maxTokens,
  }) {
    this.apiUrl = apiUrl;
    this.temperature = temperature;
    this.maxTokens = maxTokens;
    notifyListeners();
  }

  Future<String> sendMessage(List<Message> messages, String text) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl + "/ask"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'messages': [
            ...messages
                .map((msg) => {'role': msg.role, 'content': msg.content})
                .toList(),
            {'role': 'user', 'content': text}
          ],
          'temperature': temperature,
          'max_tokens': maxTokens,
        }),
      );

      // print('API response: ${response.body}');
      final parsedResponse = json.decode(response.body);
      final message = parsedResponse['response'];
      return message;
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }
}
