import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/translator_controller.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final _textController = TextEditingController();
  String _sourceLanguage = 'en';
  String _targetLanguage = 'fr';

  static const _languages = {
    'en': 'English',
    'fr': 'French',
    'es': 'Spanish',
    'de': 'German',
  };

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _swapLanguages() {
    setState(() {
      final temp = _sourceLanguage;
      _sourceLanguage = _targetLanguage;
      _targetLanguage = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TranslatorController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Enter text to translate',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _textController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Type or paste text here...',
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'From',
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _sourceLanguage,
                      isExpanded: true,
                      items: _languages.entries
                          .map((e) => DropdownMenuItem(
                                value: e.key,
                                child: Text(e.value),
                              ))
                          .toList(),
                      onChanged: controller.isLoading
                          ? null
                          : (value) =>
                              setState(() => _sourceLanguage = value ?? 'en'),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: controller.isLoading ? null : _swapLanguages,
                icon: const Icon(Icons.swap_horiz),
                tooltip: 'Swap languages',
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'To',
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _targetLanguage,
                      isExpanded: true,
                      items: _languages.entries
                          .map((e) => DropdownMenuItem(
                                value: e.key,
                                child: Text(e.value),
                              ))
                          .toList(),
                      onChanged: controller.isLoading
                          ? null
                          : (value) =>
                              setState(() => _targetLanguage = value ?? 'fr'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: controller.isLoading
                ? null
                : () async {
                    final msg = await controller.translate(
                      text: _textController.text.trim(),
                      sourceLang: _sourceLanguage,
                      targetLang: _targetLanguage,
                    );
                    if (msg != null && context.mounted) {
                      _showMessage(context, msg);
                    }
                  },
            icon: controller.isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : const Icon(Icons.translate),
            label: Text(controller.isLoading ? 'Translating...' : 'Translate'),
          ),
          if (controller.result.isNotEmpty) ...[
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(text: controller.result),
                );
                _showMessage(context, 'Copied to clipboard');
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.result,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.copy,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.tonalIcon(
                  onPressed: () {
                    final text = _textController.text.trim();
                    Share.share(
                      '$text\n↓\n${controller.result}',
                      subject: 'Translation',
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
