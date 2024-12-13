// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CreditRateDataStruct extends FFFirebaseStruct {
  CreditRateDataStruct({
    String? subject,
    int? credit,
    int? totalAnswer,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _subject = subject,
        _credit = credit,
        _totalAnswer = totalAnswer,
        super(firestoreUtilData);

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  set subject(String? val) => _subject = val;

  bool hasSubject() => _subject != null;

  // "credit" field.
  int? _credit;
  int get credit => _credit ?? 0;
  set credit(int? val) => _credit = val;

  void incrementCredit(int amount) => credit = credit + amount;

  bool hasCredit() => _credit != null;

  // "total_answer" field.
  int? _totalAnswer;
  int get totalAnswer => _totalAnswer ?? 0;
  set totalAnswer(int? val) => _totalAnswer = val;

  void incrementTotalAnswer(int amount) => totalAnswer = totalAnswer + amount;

  bool hasTotalAnswer() => _totalAnswer != null;

  static CreditRateDataStruct fromMap(Map<String, dynamic> data) =>
      CreditRateDataStruct(
        subject: data['subject'] as String?,
        credit: castToType<int>(data['credit']),
        totalAnswer: castToType<int>(data['total_answer']),
      );

  static CreditRateDataStruct? maybeFromMap(dynamic data) => data is Map
      ? CreditRateDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'subject': _subject,
        'credit': _credit,
        'total_answer': _totalAnswer,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'subject': serializeParam(
          _subject,
          ParamType.String,
        ),
        'credit': serializeParam(
          _credit,
          ParamType.int,
        ),
        'total_answer': serializeParam(
          _totalAnswer,
          ParamType.int,
        ),
      }.withoutNulls;

  static CreditRateDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      CreditRateDataStruct(
        subject: deserializeParam(
          data['subject'],
          ParamType.String,
          false,
        ),
        credit: deserializeParam(
          data['credit'],
          ParamType.int,
          false,
        ),
        totalAnswer: deserializeParam(
          data['total_answer'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'CreditRateDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CreditRateDataStruct &&
        subject == other.subject &&
        credit == other.credit &&
        totalAnswer == other.totalAnswer;
  }

  @override
  int get hashCode => const ListEquality().hash([subject, credit, totalAnswer]);
}

CreditRateDataStruct createCreditRateDataStruct({
  String? subject,
  int? credit,
  int? totalAnswer,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CreditRateDataStruct(
      subject: subject,
      credit: credit,
      totalAnswer: totalAnswer,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CreditRateDataStruct? updateCreditRateDataStruct(
  CreditRateDataStruct? creditRateData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    creditRateData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCreditRateDataStructData(
  Map<String, dynamic> firestoreData,
  CreditRateDataStruct? creditRateData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (creditRateData == null) {
    return;
  }
  if (creditRateData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && creditRateData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final creditRateDataData =
      getCreditRateDataFirestoreData(creditRateData, forFieldValue);
  final nestedData =
      creditRateDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = creditRateData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCreditRateDataFirestoreData(
  CreditRateDataStruct? creditRateData, [
  bool forFieldValue = false,
]) {
  if (creditRateData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(creditRateData.toMap());

  // Add any Firestore field values
  creditRateData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCreditRateDataListFirestoreData(
  List<CreditRateDataStruct>? creditRateDatas,
) =>
    creditRateDatas
        ?.map((e) => getCreditRateDataFirestoreData(e, true))
        .toList() ??
    [];
