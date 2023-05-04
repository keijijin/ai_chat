import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/ChatViewModel.dart';

class SettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChatViewModel>(context, listen: false);
    final apiUrlController =
        TextEditingController(text: viewModel.model.apiUrl);
    final temperatureController =
        TextEditingController(text: viewModel.model.temperature.toString());
    final maxTokensController =
        TextEditingController(text: viewModel.model.maxTokens.toString());
    return AlertDialog(
      title: Text('設定'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('API URL:'),
            TextField(controller: apiUrlController),
            SizedBox(height: 16),
            Text('Temperature:'),
            TextField(controller: temperatureController),
            SizedBox(height: 16),
            Text('Max tokens:'),
            TextField(controller: maxTokensController),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            viewModel.loadSettings();
            Navigator.pop(context);
          },
          child: Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            viewModel.updateSettings(
              apiUrl: apiUrlController.text.trim(),
              temperature:
                  double.tryParse(temperatureController.text.trim()) ?? 0.7,
              maxTokens: int.tryParse(maxTokensController.text.trim()) ?? 1024,
            );
            viewModel.saveSettings();
            Navigator.pop(context);
          },
          child: Text('保存'),
        ),
      ],
    );
  }
}
