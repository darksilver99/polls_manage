// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SummaryAnswerDataStruct extends FFFirebaseStruct {
  SummaryAnswerDataStruct({
    String? answer,
    int? total,
    int? type,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _answer = answer,
        _total = total,
        _type = type,
        super(firestoreUtilData);

  // "answer" field.
  String? _answer;
  String get answer => _answer ?? '';
  set answer(String? val) => _answer = val;

  bool hasAnswer() => _answer != null;

  // "total" field.
  int? _total;
  int get total => _total ?? 0;
  set total(int? val) => _total = val;

  void incrementTotal(int amount) => total = total + amount;

  bool hasTotal() => _total != null;

  // "type" field.
  int? _type;
  int get type => _type ?? 0;
  set type(int? val) => _type = val;

  void incrementType(int amount) => type = type + amount;

  bool hasType() => _type != null;

  static SummaryAnswerDataStruct fromMap(Map<String, dynamic> data) =>
      SummaryAnswerDataStruct(
        answer: data['answer'] as String?,
        total: castToType<int>(data['total']),
        type: castToType<int>(data['type']),
      );

  static SummaryAnswerDataStruct? maybeFromMap(dynamic data) => data is Map
      ? SummaryAnswerDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'answer': _answer,
        'total': _total,
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'answer': serializeParam(
          _answer,
          ParamType.String,
        ),
        'total': serializeParam(
          _total,
          ParamType.int,
        ),
        'type': serializeParam(
          _type,
          ParamType.int,
        ),
      }.withoutNulls;

  static SummaryAnswerDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SummaryAnswerDataStruct(
        answer: deserializeParam(
          data['answer'],
          ParamType.String,
          false,
        ),
        total: deserializeParam(
          data['total'],
          ParamType.int,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'SummaryAnswerDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SummaryAnswerDataStruct &&
        answer == other.answer &&
        total == other.total &&
        type == other.type;
  }

  @override
  int get hashCode => const ListEquality().hash([answer, total, type]);
}

SummaryAnswerDataStruct createSummaryAnswerDataStruct({
  String? answer,
  int? total,
  int? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SummaryAnswerDataStruct(
      answer: answer,
      total: total,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SummaryAnswerDataStruct? updateSummaryAnswerDataStruct(
  SummaryAnswerDataStruct? summaryAnswerData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    summaryAnswerData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSummaryAnswerDataStructData(
  Map<String, dynamic> firestoreData,
  SummaryAnswerDataStruct? summaryAnswerData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (summaryAnswerData == null) {
    return;
  }
  if (summaryAnswerData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && summaryAnswerData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final summaryAnswerDataData =
      getSummaryAnswerDataFirestoreData(summaryAnswerData, forFieldValue);
  final nestedData =
      summaryAnswerDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = summaryAnswerData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSummaryAnswerDataFirestoreData(
  SummaryAnswerDataStruct? summaryAnswerData, [
  bool forFieldValue = false,
]) {
  if (summaryAnswerData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(summaryAnswerData.toMap());

  // Add any Firestore field values
  summaryAnswerData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSummaryAnswerDataListFirestoreData(
  List<SummaryAnswerDataStruct>? summaryAnswerDatas,
) =>
    summaryAnswerDatas
        ?.map((e) => getSummaryAnswerDataFirestoreData(e, true))
        .toList() ??
    [];
