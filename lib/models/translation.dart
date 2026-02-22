class Translation {
  const Translation({
    required this.id,
    required this.sourceText,
    required this.translatedText,
    required this.sourceLanguage,
    required this.targetLanguage,
    this.createdAt,
  });

  final String id;
  final String sourceText;
  final String translatedText;
  final String sourceLanguage;
  final String targetLanguage;
  final DateTime? createdAt;

  Map<String, dynamic> toMap() {
    final created = createdAt ?? DateTime.now();
    return {
      'sourceText': sourceText,
      'translatedText': translatedText,
      'sourceLanguage': sourceLanguage,
      'targetLanguage': targetLanguage,
      'createdAt': created.toIso8601String(),
    };
  }

  factory Translation.fromMap(String id, Map<String, dynamic> map) {
    DateTime? createdAt;
    final ts = map['createdAt'];
    if (ts != null && ts is String) {
      createdAt = DateTime.tryParse(ts);
    }
    return Translation(
      id: id,
      sourceText: map['sourceText'] as String? ?? '',
      translatedText: map['translatedText'] as String? ?? '',
      sourceLanguage: map['sourceLanguage'] as String? ?? 'en',
      targetLanguage: map['targetLanguage'] as String? ?? 'fr',
      createdAt: createdAt,
    );
  }
}
