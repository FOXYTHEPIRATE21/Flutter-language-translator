import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  final languages = {
    "English": "en",
    "Hindi": "hi",
    "Spanish": "es",
    "French": "fr",
    "German": "de",
    "Italian": "it",
    "Japanese": "ja",
    "Korean": "ko",
    "Russian": "ru",
    "Chinese": "zh"
  };

  String originLanguage = "English";
  String destinationLanguage = "Spanish";
  String output = "";
  bool isTranslating = false;
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  final translator = GoogleTranslator();

  void _swapLanguages() {
    setState(() {
      final temp = originLanguage;
      originLanguage = destinationLanguage;
      destinationLanguage = temp;
      if (_inputController.text.isNotEmpty && output.isNotEmpty) {
        _inputController.text = output;
        output = "";
      }
    });
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Text copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _translate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isTranslating = true;
      output = "";
    });

    try {
      final translation = await translator.translate(
        _inputController.text,
        from: languages[originLanguage]!,
        to: languages[destinationLanguage]!,
      );

      setState(() {
        output = translation.text;
        isTranslating = false;
      });
    } catch (e) {
      setState(() {
        output = "Translation failed. Please try again.";
        isTranslating = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error occurred during translation'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/languages.png', height: 32),
            const SizedBox(width: 8),
            const Text('Translator Master'),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Language Selection
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildLanguageDropdown(
                            value: originLanguage,
                            onChanged: (value) {
                              setState(() => originLanguage = value!);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: IconButton(
                            icon: const Icon(Icons.swap_horiz),
                            onPressed: _swapLanguages,
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),
                        Expanded(
                          child: _buildLanguageDropdown(
                            value: destinationLanguage,
                            onChanged: (value) {
                              setState(() => destinationLanguage = value!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Input Section
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _inputController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Enter text to translate...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: isTranslating ? null : _translate,
                          icon: isTranslating 
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.translate),
                          label: Text(isTranslating ? 'Translating...' : 'Translate'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Output Section
                if (output.isNotEmpty)
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Translation',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () => _copyToClipboard(output),
                                tooltip: 'Copy to clipboard',
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 8),
                          SelectableText(
                            output,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown({
    required String value,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: DropdownButton<String>(
        value: value,
        items: languages.keys.map((String language) {
          return DropdownMenuItem(
            value: language,
            child: Text(language),
          );
        }).toList(),
        onChanged: onChanged,
        isExpanded: true,
        underline: const SizedBox(),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}