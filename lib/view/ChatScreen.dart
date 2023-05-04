import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/ChatViewModel.dart';
import 'ChatInput.dart';
import 'ChatList.dart';
import 'SettingsDialog.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      appBar: AppBar(
        title: Text('AI Chat'),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => SettingsDialog(),
            ),
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Provider.of<ChatViewModel>(context, listen: false)
                  .clearMessages();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
