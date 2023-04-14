import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Message.dart';

class ChatModel {
  String apiUrl;
  double temperature;
  int maxTokens;
  List<Message> messages = [];

  ChatModel(
      {required this.apiUrl,
      required this.temperature,
      required this.maxTokens});

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
