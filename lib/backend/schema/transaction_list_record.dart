import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionListRecord extends FirestoreRecord {
  TransactionListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "create_date" field.
  DateTime? _createDate;
  DateTime? get createDate => _createDate;
  bool hasCreateDate() => _createDate != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "poll_ref" field.
  DocumentReference? _pollRef;
  DocumentReference? get pollRef => _pollRef;
  bool hasPollRef() => _pollRef != null;

  // "credit" field.
  int? _credit;
  int get credit => _credit ?? 0;
  bool hasCredit() => _credit != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _type = snapshotData['type'] as String?;
    _pollRef = snapshotData['poll_ref'] as DocumentReference?;
    _credit = castToType<int>(snapshotData['credit']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('transaction_list')
          : FirebaseFirestore.instance.collectionGroup('transaction_list');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('transaction_list').doc(id);

  static Stream<TransactionListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TransactionListRecord.fromSnapshot(s));

  static Future<TransactionListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TransactionListRecord.fromSnapshot(s));

  static TransactionListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TransactionListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TransactionListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TransactionListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TransactionListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TransactionListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTransactionListRecordData({
  DateTime? createDate,
  String? type,
  DocumentReference? pollRef,
  int? credit,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'type': type,
      'poll_ref': pollRef,
      'credit': credit,
    }.withoutNulls,
  );

  return firestoreData;
}

class TransactionListRecordDocumentEquality
    implements Equality<TransactionListRecord> {
  const TransactionListRecordDocumentEquality();

  @override
  bool equals(TransactionListRecord? e1, TransactionListRecord? e2) {
    return e1?.createDate == e2?.createDate &&
        e1?.type == e2?.type &&
        e1?.pollRef == e2?.pollRef &&
        e1?.credit == e2?.credit;
  }

  @override
  int hash(TransactionListRecord? e) => const ListEquality()
      .hash([e?.createDate, e?.type, e?.pollRef, e?.credit]);

  @override
  bool isValidKey(Object? o) => o is TransactionListRecord;
}
