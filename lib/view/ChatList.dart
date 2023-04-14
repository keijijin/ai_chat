import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/ChatViewModel.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, viewModel, child) => ListView.builder(
        itemCount: viewModel.messages.length,
        itemBuilder: (context, index) {
          final message = viewModel.messages[index];
          final isUserMessage = message.role == 'user';
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment:
                isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(message.content),
            ),
          );
        },
      ),
    );
  }
}
