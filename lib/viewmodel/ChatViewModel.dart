import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/ChatModel.dart';
import '../model/Message.dart';

class ChatViewModel extends ChangeNotifier {
  ChatModel _model;
  List<Message> _messages = [];
  bool _isLoading = false;

  ChatViewModel({required ChatModel model}) : _model = model;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  // _model の getter を追加
  ChatModel get model => _model;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final apiUrl = prefs.getString('apiUrl') ?? model.apiUrl;
    final temperature = prefs.getDouble('temperature') ?? model.temperature;
    final maxTokens = prefs.getInt('maxTokens') ?? model.maxTokens;
    updateSettings(
        apiUrl: apiUrl, temperature: temperature, maxTokens: maxTokens);
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('apiUrl', model.apiUrl);
    prefs.setDouble('temperature', model.temperature);
    prefs.setInt('maxTokens', model.maxTokens);
  }

  void updateSettings(
      {required String apiUrl,
      required double temperature,
      required int maxTokens}) {
    _model.apiUrl = apiUrl;
    _model.temperature = temperature;
    _model.maxTokens = maxTokens;
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _model.sendMessage(_messages, text);
      _messages.add(Message(role: 'user', content: text));
      _messages.add(Message(role: 'assistant', content: response));
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
