import 'package:flutter/foundation.dart';

import '../models/translation.dart';
import '../services/connectivity_service.dart';
import '../services/history_service.dart';
import '../services/translation_service.dart';

class TranslatorController extends ChangeNotifier {
  TranslatorController({
    required TranslationService translationService,
    required HistoryService historyService,
    required ConnectivityService connectivityService,
  })  : _translationService = translationService,
        _historyService = historyService,
        _connectivityService = connectivityService;

  final TranslationService _translationService;
  final HistoryService _historyService;
  final ConnectivityService _connectivityService;

  bool _isLoading = false;
  String _result = '';

  bool get isLoading => _isLoading;
  String get result => _result;

  Future<String?> translate({
    required String text,
    required String sourceLang,
    required String targetLang,
  }) async {
    if (text.trim().isEmpty) {
      return 'Please enter text to translate';
    }

    final connected = await _connectivityService.isConnected;
    if (!connected) {
      return 'No internet connection. Please check your network and try again.';
    }

    _isLoading = true;
    _result = '';
    notifyListeners();

    try {
      final translated = await _translationService.translate(
        text: text,
        sourceLang: sourceLang,
        targetLang: targetLang,
      );

      final translation = Translation(
        id: '',
        sourceText: text,
        translatedText: translated,
        sourceLanguage: sourceLang,
        targetLanguage: targetLang,
        createdAt: DateTime.now(),
      );

      try {
        await _historyService.save(translation);
      } catch (_) {
      }

      _result = translated;
      _isLoading = false;
      notifyListeners();
      return null;
    } on TranslationException catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.message;
    } catch (_) {
      _isLoading = false;
      notifyListeners();
      return 'Unable to translate. Please check your internet connection.';
    }
  }
}
