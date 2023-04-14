import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/ChatViewModel.dart';

class ChatInput extends StatefulWidget {
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, viewModel, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'メッセージを入力',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onSubmitted: (value) async {
                  if (value.trim().isNotEmpty && !viewModel.isLoading) {
                    await viewModel.sendMessage(value.trim());
                    setState(() {
                      _controller.clear();
                    });
                  }
                },
              ),
            ),
            SizedBox(width: 8),
            viewModel.isLoading
                ? CircularProgressIndicator()
                : IconButton(
                    onPressed: () async {
                      if (_controller.text.trim().isNotEmpty &&
                          !viewModel.isLoading) {
                        await viewModel.sendMessage(_controller.text.trim());
                        setState(() {
                          _controller.clear();
                        });
                      }
                    },
                    icon: Icon(Icons.send),
                  ),
          ],
        ),
      ),
    );
  }
}
