// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PollDataStruct extends FFFirebaseStruct {
  PollDataStruct({
    String? subject,
    String? detail,
    DateTime? startDate,
    DateTime? endDate,
    List<QuestionDataStruct>? questionList,
    bool? isDraft,
    DocumentReference? pollReference,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _subject = subject,
        _detail = detail,
        _startDate = startDate,
        _endDate = endDate,
        _questionList = questionList,
        _isDraft = isDraft,
        _pollReference = pollReference,
        super(firestoreUtilData);

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  set subject(String? val) => _subject = val;

  bool hasSubject() => _subject != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  set detail(String? val) => _detail = val;

  bool hasDetail() => _detail != null;

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  set startDate(DateTime? val) => _startDate = val;

  bool hasStartDate() => _startDate != null;

  // "end_date" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  set endDate(DateTime? val) => _endDate = val;

  bool hasEndDate() => _endDate != null;

  // "question_list" field.
  List<QuestionDataStruct>? _questionList;
  List<QuestionDataStruct> get questionList => _questionList ?? const [];
  set questionList(List<QuestionDataStruct>? val) => _questionList = val;

  void updateQuestionList(Function(List<QuestionDataStruct>) updateFn) {
    updateFn(_questionList ??= []);
  }

  bool hasQuestionList() => _questionList != null;

  // "is_draft" field.
  bool? _isDraft;
  bool get isDraft => _isDraft ?? false;
  set isDraft(bool? val) => _isDraft = val;

  bool hasIsDraft() => _isDraft != null;

  // "poll_reference" field.
  DocumentReference? _pollReference;
  DocumentReference? get pollReference => _pollReference;
  set pollReference(DocumentReference? val) => _pollReference = val;

  bool hasPollReference() => _pollReference != null;

  static PollDataStruct fromMap(Map<String, dynamic> data) => PollDataStruct(
        subject: data['subject'] as String?,
        detail: data['detail'] as String?,
        startDate: data['start_date'] as DateTime?,
        endDate: data['end_date'] as DateTime?,
        questionList: getStructList(
          data['question_list'],
          QuestionDataStruct.fromMap,
        ),
        isDraft: data['is_draft'] as bool?,
        pollReference: data['poll_reference'] as DocumentReference?,
      );

  static PollDataStruct? maybeFromMap(dynamic data) =>
      data is Map ? PollDataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'subject': _subject,
        'detail': _detail,
        'start_date': _startDate,
        'end_date': _endDate,
        'question_list': _questionList?.map((e) => e.toMap()).toList(),
        'is_draft': _isDraft,
        'poll_reference': _pollReference,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'subject': serializeParam(
          _subject,
          ParamType.String,
        ),
        'detail': serializeParam(
          _detail,
          ParamType.String,
        ),
        'start_date': serializeParam(
          _startDate,
          ParamType.DateTime,
        ),
        'end_date': serializeParam(
          _endDate,
          ParamType.DateTime,
        ),
        'question_list': serializeParam(
          _questionList,
          ParamType.DataStruct,
          isList: true,
        ),
        'is_draft': serializeParam(
          _isDraft,
          ParamType.bool,
        ),
        'poll_reference': serializeParam(
          _pollReference,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static PollDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      PollDataStruct(
        subject: deserializeParam(
          data['subject'],
          ParamType.String,
          false,
        ),
        detail: deserializeParam(
          data['detail'],
          ParamType.String,
          false,
        ),
        startDate: deserializeParam(
          data['start_date'],
          ParamType.DateTime,
          false,
        ),
        endDate: deserializeParam(
          data['end_date'],
          ParamType.DateTime,
          false,
        ),
        questionList: deserializeStructParam<QuestionDataStruct>(
          data['question_list'],
          ParamType.DataStruct,
          true,
          structBuilder: QuestionDataStruct.fromSerializableMap,
        ),
        isDraft: deserializeParam(
          data['is_draft'],
          ParamType.bool,
          false,
        ),
        pollReference: deserializeParam(
          data['poll_reference'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['customer_list', 'poll_list'],
        ),
      );

  @override
  String toString() => 'PollDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PollDataStruct &&
        subject == other.subject &&
        detail == other.detail &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        listEquality.equals(questionList, other.questionList) &&
        isDraft == other.isDraft &&
        pollReference == other.pollReference;
  }

  @override
  int get hashCode => const ListEquality().hash([
        subject,
        detail,
        startDate,
        endDate,
        questionList,
        isDraft,
        pollReference
      ]);
}

PollDataStruct createPollDataStruct({
  String? subject,
  String? detail,
  DateTime? startDate,
  DateTime? endDate,
  bool? isDraft,
  DocumentReference? pollReference,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PollDataStruct(
      subject: subject,
      detail: detail,
      startDate: startDate,
      endDate: endDate,
      isDraft: isDraft,
      pollReference: pollReference,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PollDataStruct? updatePollDataStruct(
  PollDataStruct? pollData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pollData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPollDataStructData(
  Map<String, dynamic> firestoreData,
  PollDataStruct? pollData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pollData == null) {
    return;
  }
  if (pollData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && pollData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pollDataData = getPollDataFirestoreData(pollData, forFieldValue);
  final nestedData = pollDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pollData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPollDataFirestoreData(
  PollDataStruct? pollData, [
  bool forFieldValue = false,
]) {
  if (pollData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pollData.toMap());

  // Add any Firestore field values
  pollData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPollDataListFirestoreData(
  List<PollDataStruct>? pollDatas,
) =>
    pollDatas?.map((e) => getPollDataFirestoreData(e, true)).toList() ?? [];
