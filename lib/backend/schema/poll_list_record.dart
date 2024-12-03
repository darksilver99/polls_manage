import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PollListRecord extends FirestoreRecord {
  PollListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "create_date" field.
  DateTime? _createDate;
  DateTime? get createDate => _createDate;
  bool hasCreateDate() => _createDate != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  bool hasStatus() => _status != null;

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "end_date" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  bool hasSubject() => _subject != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  bool hasDetail() => _detail != null;

  // "question_list" field.
  List<QuestionDataStruct>? _questionList;
  List<QuestionDataStruct> get questionList => _questionList ?? const [];
  bool hasQuestionList() => _questionList != null;

  // "is_draft" field.
  bool? _isDraft;
  bool get isDraft => _isDraft ?? false;
  bool hasIsDraft() => _isDraft != null;

  // "poll_path" field.
  String? _pollPath;
  String get pollPath => _pollPath ?? '';
  bool hasPollPath() => _pollPath != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _status = castToType<int>(snapshotData['status']);
    _startDate = snapshotData['start_date'] as DateTime?;
    _endDate = snapshotData['end_date'] as DateTime?;
    _subject = snapshotData['subject'] as String?;
    _detail = snapshotData['detail'] as String?;
    _questionList = getStructList(
      snapshotData['question_list'],
      QuestionDataStruct.fromMap,
    );
    _isDraft = snapshotData['is_draft'] as bool?;
    _pollPath = snapshotData['poll_path'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('poll_list')
          : FirebaseFirestore.instance.collectionGroup('poll_list');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('poll_list').doc(id);

  static Stream<PollListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PollListRecord.fromSnapshot(s));

  static Future<PollListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PollListRecord.fromSnapshot(s));

  static PollListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PollListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PollListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PollListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PollListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PollListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPollListRecordData({
  DateTime? createDate,
  int? status,
  DateTime? startDate,
  DateTime? endDate,
  String? subject,
  String? detail,
  bool? isDraft,
  String? pollPath,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'status': status,
      'start_date': startDate,
      'end_date': endDate,
      'subject': subject,
      'detail': detail,
      'is_draft': isDraft,
      'poll_path': pollPath,
    }.withoutNulls,
  );

  return firestoreData;
}

class PollListRecordDocumentEquality implements Equality<PollListRecord> {
  const PollListRecordDocumentEquality();

  @override
  bool equals(PollListRecord? e1, PollListRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createDate == e2?.createDate &&
        e1?.status == e2?.status &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.subject == e2?.subject &&
        e1?.detail == e2?.detail &&
        listEquality.equals(e1?.questionList, e2?.questionList) &&
        e1?.isDraft == e2?.isDraft &&
        e1?.pollPath == e2?.pollPath;
  }

  @override
  int hash(PollListRecord? e) => const ListEquality().hash([
        e?.createDate,
        e?.status,
        e?.startDate,
        e?.endDate,
        e?.subject,
        e?.detail,
        e?.questionList,
        e?.isDraft,
        e?.pollPath
      ]);

  @override
  bool isValidKey(Object? o) => o is PollListRecord;
}
