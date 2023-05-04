import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/ChatModel.dart';
import 'view/ChatScreen.dart';
import 'viewmodel/ChatViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  // SharedPreferences から設定を読み込む
  final prefs = await SharedPreferences.getInstance();
  final apiUrl = prefs.getString('apiUrl') ?? dotenv.env['API_URL'] ?? '';
  final temperature = prefs.getDouble('temperature') ?? 0.7;
  final maxTokens = prefs.getInt('maxTokens') ?? 1024;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatViewModel(
        model: ChatModel(
          apiUrl: apiUrl,
          temperature: 0.7,
          maxTokens: 1024,
        ),
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Interface',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(key: UniqueKey()),
      debugShowCheckedModeBanner: false,
    );
  }
}
