import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/translation.dart';

class HistoryService {
  HistoryService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _collection = 'translations';

  Future<String> save(Translation translation) async {
    final doc = _firestore.collection(_collection).doc();
    await doc.set(translation.toMap());
    return doc.id;
  }

  Stream<List<Translation>>? _translationsStream;

  Stream<List<Translation>> getTranslationsStream() {
    _translationsStream ??= _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Translation.fromMap(doc.id, doc.data()))
              .toList(),
        );
    return _translationsStream!;
  }

  Future<List<Translation>> getTranslations() async {
    final snapshot = await _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Translation.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> delete(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  Future<void> clearAll() async {
    final snapshot = await _firestore.collection(_collection).get();
    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
