// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SummaryDataStruct extends FFFirebaseStruct {
  SummaryDataStruct({
    String? question,
    List<SummaryAnswerDataStruct>? answers,
    int? type,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _question = question,
        _answers = answers,
        _type = type,
        super(firestoreUtilData);

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  set question(String? val) => _question = val;

  bool hasQuestion() => _question != null;

  // "answers" field.
  List<SummaryAnswerDataStruct>? _answers;
  List<SummaryAnswerDataStruct> get answers => _answers ?? const [];
  set answers(List<SummaryAnswerDataStruct>? val) => _answers = val;

  void updateAnswers(Function(List<SummaryAnswerDataStruct>) updateFn) {
    updateFn(_answers ??= []);
  }

  bool hasAnswers() => _answers != null;

  // "type" field.
  int? _type;
  int get type => _type ?? 0;
  set type(int? val) => _type = val;

  void incrementType(int amount) => type = type + amount;

  bool hasType() => _type != null;

  static SummaryDataStruct fromMap(Map<String, dynamic> data) =>
      SummaryDataStruct(
        question: data['question'] as String?,
        answers: getStructList(
          data['answers'],
          SummaryAnswerDataStruct.fromMap,
        ),
        type: castToType<int>(data['type']),
      );

  static SummaryDataStruct? maybeFromMap(dynamic data) => data is Map
      ? SummaryDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'question': _question,
        'answers': _answers?.map((e) => e.toMap()).toList(),
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'question': serializeParam(
          _question,
          ParamType.String,
        ),
        'answers': serializeParam(
          _answers,
          ParamType.DataStruct,
          isList: true,
        ),
        'type': serializeParam(
          _type,
          ParamType.int,
        ),
      }.withoutNulls;

  static SummaryDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      SummaryDataStruct(
        question: deserializeParam(
          data['question'],
          ParamType.String,
          false,
        ),
        answers: deserializeStructParam<SummaryAnswerDataStruct>(
          data['answers'],
          ParamType.DataStruct,
          true,
          structBuilder: SummaryAnswerDataStruct.fromSerializableMap,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'SummaryDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SummaryDataStruct &&
        question == other.question &&
        listEquality.equals(answers, other.answers) &&
        type == other.type;
  }

  @override
  int get hashCode => const ListEquality().hash([question, answers, type]);
}

SummaryDataStruct createSummaryDataStruct({
  String? question,
  int? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SummaryDataStruct(
      question: question,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SummaryDataStruct? updateSummaryDataStruct(
  SummaryDataStruct? summaryData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    summaryData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSummaryDataStructData(
  Map<String, dynamic> firestoreData,
  SummaryDataStruct? summaryData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (summaryData == null) {
    return;
  }
  if (summaryData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && summaryData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final summaryDataData =
      getSummaryDataFirestoreData(summaryData, forFieldValue);
  final nestedData =
      summaryDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = summaryData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSummaryDataFirestoreData(
  SummaryDataStruct? summaryData, [
  bool forFieldValue = false,
]) {
  if (summaryData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(summaryData.toMap());

  // Add any Firestore field values
  summaryData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSummaryDataListFirestoreData(
  List<SummaryDataStruct>? summaryDatas,
) =>
    summaryDatas?.map((e) => getSummaryDataFirestoreData(e, true)).toList() ??
    [];
