import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'model/ChatModel.dart';
import 'view/ChatScreen.dart';
import 'viewmodel/ChatViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final apiUrl = dotenv.env['API_URL'] ?? '';
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
