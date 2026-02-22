import 'dart:convert';

import 'package:http/http.dart' as http;

class TranslationService {
  TranslationService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _baseUrl = 'https://api.mymemory.translated.net/get';

  Future<String> translate({
    required String text,
    required String sourceLang,
    required String targetLang,
  }) async {
    if (text.trim().isEmpty) {
      return '';
    }

    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'q': text,
        'langpair': '$sourceLang|$targetLang',
      },
    );

    try {
      final response = await _client.get(uri).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw TranslationException(
          'Request timed out. Please check your internet connection.',
        ),
      );

      if (response.statusCode != 200) {
        throw TranslationException(
          'Translation failed (${response.statusCode}). Please try again.',
        );
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final responseData = json['responseData'] as Map<String, dynamic>?;
      if (responseData == null) {
        throw TranslationException('Invalid response from translation service.');
      }

      final translatedText = responseData['translatedText'] as String? ?? '';
      final quotaFinished = json['quotaFinished'] == true;

      if (quotaFinished) {
        throw TranslationException(
          'Daily translation limit reached. Please try again tomorrow.',
        );
      }

      return translatedText;
    } on FormatException {
      throw TranslationException('Invalid response from translation service.');
    } catch (e) {
      if (e is TranslationException) rethrow;
      throw TranslationException(
        'Unable to translate. Please check your internet connection.',
      );
    }
  }
}

class TranslationException implements Exception {
  TranslationException(this.message);
  final String message;

  @override
  String toString() => message;
}
