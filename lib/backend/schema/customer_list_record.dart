import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CustomerListRecord extends FirestoreRecord {
  CustomerListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "create_date" field.
  DateTime? _createDate;
  DateTime? get createDate => _createDate;
  bool hasCreateDate() => _createDate != null;

  // "create_by" field.
  DocumentReference? _createBy;
  DocumentReference? get createBy => _createBy;
  bool hasCreateBy() => _createBy != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  bool hasStatus() => _status != null;

  // "expire_date" field.
  DateTime? _expireDate;
  DateTime? get expireDate => _expireDate;
  bool hasExpireDate() => _expireDate != null;

  // "customer_name" field.
  String? _customerName;
  String get customerName => _customerName ?? '';
  bool hasCustomerName() => _customerName != null;

  // "credit_rate" field.
  List<CreditRateDataStruct>? _creditRate;
  List<CreditRateDataStruct> get creditRate => _creditRate ?? const [];
  bool hasCreditRate() => _creditRate != null;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _createBy = snapshotData['create_by'] as DocumentReference?;
    _status = castToType<int>(snapshotData['status']);
    _expireDate = snapshotData['expire_date'] as DateTime?;
    _customerName = snapshotData['customer_name'] as String?;
    _creditRate = getStructList(
      snapshotData['credit_rate'],
      CreditRateDataStruct.fromMap,
    );
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('customer_list');

  static Stream<CustomerListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CustomerListRecord.fromSnapshot(s));

  static Future<CustomerListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CustomerListRecord.fromSnapshot(s));

  static CustomerListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CustomerListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CustomerListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CustomerListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CustomerListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CustomerListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCustomerListRecordData({
  DateTime? createDate,
  DocumentReference? createBy,
  int? status,
  DateTime? expireDate,
  String? customerName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'create_by': createBy,
      'status': status,
      'expire_date': expireDate,
      'customer_name': customerName,
    }.withoutNulls,
  );

  return firestoreData;
}

class CustomerListRecordDocumentEquality
    implements Equality<CustomerListRecord> {
  const CustomerListRecordDocumentEquality();

  @override
  bool equals(CustomerListRecord? e1, CustomerListRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createDate == e2?.createDate &&
        e1?.createBy == e2?.createBy &&
        e1?.status == e2?.status &&
        e1?.expireDate == e2?.expireDate &&
        e1?.customerName == e2?.customerName &&
        listEquality.equals(e1?.creditRate, e2?.creditRate);
  }

  @override
  int hash(CustomerListRecord? e) => const ListEquality().hash([
        e?.createDate,
        e?.createBy,
        e?.status,
        e?.expireDate,
        e?.customerName,
        e?.creditRate
      ]);

  @override
  bool isValidKey(Object? o) => o is CustomerListRecord;
}
