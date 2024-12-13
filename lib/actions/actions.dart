import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/component/confirm_custom_view/confirm_custom_view_widget.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/poll_view/poll_component/q_r_code_poll_view/q_r_code_poll_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

Future initConfig(BuildContext context) async {
  ConfigRecord? configResult;

  configResult = await queryConfigRecordOnce(
    singleRecord: true,
  ).then((s) => s.firstOrNull);
  FFAppState().configData = ConfigDataStruct(
    contact: configResult?.contact,
    freeDay: configResult?.freeDay,
    isReview: configResult?.isReview,
    paymentAlertText: configResult?.paymentAlertText,
    paymentDetailImage: configResult?.paymentDetailImage,
    policyUrl: configResult?.policyUrl,
    promotionDetailImage: configResult?.promotionDetailImage,
    storeAndroidLink: configResult?.storeAndroidLink,
    storeIosLink: configResult?.storeIosLink,
    storeVersion: configResult?.storeVersion,
    appSuggestList: configResult?.appSuggestList,
    appOtherList: configResult?.appOtherList,
    pollUrl: configResult?.pollUrl,
    defaultCreditRate: configResult?.defaultCreditRate,
  );
}

Future<bool?> confirmBlock(
  BuildContext context, {
  required String? title,
  String? detail,
}) async {
  bool? isConfirm;

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment:
            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
        child: WebViewAware(
          child: ConfirmCustomViewWidget(
            title: title!,
            detail: detail,
          ),
        ),
      );
    },
  ).then((value) => isConfirm = value);

  if ((isConfirm != null) && isConfirm!) {
    return true;
  }

  return false;
}

Future initCustomer(BuildContext context) async {
  CustomerListRecord? customerResult;

  customerResult = await queryCustomerListRecordOnce(
    queryBuilder: (customerListRecord) => customerListRecord.where(
      'create_by',
      isEqualTo: currentUserReference,
    ),
    singleRecord: true,
  ).then((s) => s.firstOrNull);
  if (customerResult != null) {
    FFAppState().customerData = CustomerDataStruct(
      expireDate: customerResult?.expireDate,
      customerRef: customerResult?.reference,
      customerName: customerResult?.customerName,
      creditRate: customerResult?.creditRate,
    );
  } else {
    await CustomerListRecord.collection.doc().set({
      ...createCustomerListRecordData(
        createDate: getCurrentTimestamp,
        createBy: currentUserReference,
        status: 1,
        expireDate: functions.getEndDayTime(functions.getNextDay(
            FFAppState().configData.freeDay, getCurrentTimestamp)),
        customerName: currentUserEmail,
      ),
      ...mapToFirestore(
        {
          'credit_rate': getCreditRateDataListFirestoreData(
            FFAppState().configData.defaultCreditRate,
          ),
        },
      ),
    });
    if (!FFAppState().configData.isReview) {
      await showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            alignment: AlignmentDirectional(0.0, 0.0)
                .resolve(Directionality.of(context)),
            child: WebViewAware(
              child: InfoCustomViewWidget(
                title:
                    'พิเศษสำหรับสมาชิกใหม่ ทดลองใช้ฟรี ${FFAppState().configData.freeDay.toString()} วัน',
                status: 'success',
              ),
            ),
          );
        },
      );
    }
    await action_blocks.initCustomer(context);
  }
}

Future checkQRCode(BuildContext context) async {
  var qrCode = '';
  PollListRecord? pollResult;

  qrCode = await FlutterBarcodeScanner.scanBarcode(
    '#C62828', // scanning line color
    'Cancel', // cancel button text
    true, // whether to show the flash icon
    ScanMode.QR,
  );

  if (qrCode != null && qrCode != '') {
    pollResult = await actions.checkIsCorrectQrCode(
      qrCode,
    );
    if (pollResult != null) {
      context.pushNamed(
        'PollDetailPage',
        queryParameters: {
          'pollDocument': serializeParam(
            pollResult,
            ParamType.Document,
          ),
        }.withoutNulls,
        extra: <String, dynamic>{
          'pollDocument': pollResult,
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            alignment: AlignmentDirectional(0.0, 0.0)
                .resolve(Directionality.of(context)),
            child: WebViewAware(
              child: InfoCustomViewWidget(
                title: 'ไม่มีรายการนี้แล้ว',
                status: 'warning',
              ),
            ),
          );
        },
      );
    }
  }
}

Future insertTransactionData(
  BuildContext context, {
  required DocumentReference? pollReference,
  required String? type,
  required int? credit,
}) async {
  await TransactionListRecord.createDoc(FFAppState().customerData.customerRef!)
      .set(createTransactionListRecordData(
    createDate: getCurrentTimestamp,
    type: type,
    pollRef: pollReference,
    credit: credit,
  ));
}

Future insertDraftPoll(BuildContext context) async {
  PollListRecord? insertedDarft;

  var pollListRecordReference =
      PollListRecord.createDoc(FFAppState().customerData.customerRef!);
  await pollListRecordReference.set({
    ...createPollListRecordData(
      createDate: getCurrentTimestamp,
      status: 1,
      subject: FFAppState().tmpPollData.subject,
      detail: FFAppState().tmpPollData.detail,
      isDraft: true,
      maxAnswer: FFAppState().tmpPollData.maxAnswer,
    ),
    ...mapToFirestore(
      {
        'question_list': getQuestionDataListFirestoreData(
          FFAppState().tmpQuestionDataList,
        ),
      },
    ),
  });
  insertedDarft = PollListRecord.getDocumentFromData({
    ...createPollListRecordData(
      createDate: getCurrentTimestamp,
      status: 1,
      subject: FFAppState().tmpPollData.subject,
      detail: FFAppState().tmpPollData.detail,
      isDraft: true,
      maxAnswer: FFAppState().tmpPollData.maxAnswer,
    ),
    ...mapToFirestore(
      {
        'question_list': getQuestionDataListFirestoreData(
          FFAppState().tmpQuestionDataList,
        ),
      },
    ),
  }, pollListRecordReference);
  await action_blocks.insertTransactionData(
    context,
    pollReference: insertedDarft?.reference,
    type: 'สร้างแบบร่าง',
    credit: 0,
  );

  await insertedDarft!.reference.update(createPollListRecordData(
    pollPath:
        'customer_list/${FFAppState().customerData.customerRef?.id}/poll_list/${insertedDarft?.reference.id}',
  ));
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment:
            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
        child: WebViewAware(
          child: InfoCustomViewWidget(
            title: 'บันทึกข้อมูลเรียบร้อยแล้ว',
            status: 'success',
          ),
        ),
      );
    },
  );

  await actions.pushReplacement(
    context,
    null,
  );
}

Future insertPoll(BuildContext context) async {
  PollListRecord? insertedPoll;
  PollListRecord? pollResult;

  var pollListRecordReference1 =
      PollListRecord.createDoc(FFAppState().customerData.customerRef!);
  await pollListRecordReference1.set({
    ...createPollListRecordData(
      createDate: getCurrentTimestamp,
      status: 1,
      subject: FFAppState().tmpPollData.subject,
      detail: FFAppState().tmpPollData.detail,
      isDraft: false,
      maxAnswer: FFAppState().tmpPollData.maxAnswer,
      editExpire: functions.getNextTime(60, getCurrentTimestamp),
    ),
    ...mapToFirestore(
      {
        'question_list': getQuestionDataListFirestoreData(
          FFAppState().tmpPollData.questionList,
        ),
      },
    ),
  });
  insertedPoll = PollListRecord.getDocumentFromData({
    ...createPollListRecordData(
      createDate: getCurrentTimestamp,
      status: 1,
      subject: FFAppState().tmpPollData.subject,
      detail: FFAppState().tmpPollData.detail,
      isDraft: false,
      maxAnswer: FFAppState().tmpPollData.maxAnswer,
      editExpire: functions.getNextTime(60, getCurrentTimestamp),
    ),
    ...mapToFirestore(
      {
        'question_list': getQuestionDataListFirestoreData(
          FFAppState().tmpPollData.questionList,
        ),
      },
    ),
  }, pollListRecordReference1);
  await action_blocks.insertTransactionData(
    context,
    pollReference: insertedPoll?.reference,
    type: 'สร้าง',
    credit: functions.getCreditRate(FFAppState().tmpPollData.maxAnswer,
        FFAppState().customerData.creditRate.toList()),
  );

  await insertedPoll!.reference.update(createPollListRecordData(
    pollPath:
        'customer_list/${FFAppState().customerData.customerRef?.id}/poll_list/${insertedPoll?.reference.id}',
  ));
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment:
            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
        child: WebViewAware(
          child: InfoCustomViewWidget(
            title: 'บันทึกข้อมูลเรียบร้อยแล้ว',
            status: 'success',
            detail:
                'คุณสามารถแก้ไขแบบสำรวจนี้ได้ภายใน 1 ชั่วโมงหลังจากการสร้าง หลังจากนั้นจะไม่สามารถแก้ไขได้อีก',
          ),
        ),
      );
    },
  );

  pollResult = await PollListRecord.getDocumentOnce(insertedPoll!.reference);
  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: false,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return WebViewAware(
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: QRCodePollViewWidget(
            pollDocument: pollResult!,
          ),
        ),
      );
    },
  );

  await actions.pushReplacement(
    context,
    null,
  );
}

Future updatePoll(BuildContext context) async {
  await FFAppState().tmpPollData.pollReference!.update({
    ...createPollListRecordData(
      subject: FFAppState().tmpPollData.subject,
      detail: FFAppState().tmpPollData.detail,
      isDraft: false,
      updateDate: getCurrentTimestamp,
      maxAnswer: FFAppState().tmpPollData.maxAnswer,
    ),
    ...mapToFirestore(
      {
        'question_list': getQuestionDataListFirestoreData(
          FFAppState().tmpQuestionDataList,
        ),
      },
    ),
  });
  await action_blocks.insertTransactionData(
    context,
    pollReference: FFAppState().tmpPollData.pollReference,
    type: 'แก้ไข',
    credit: 0,
  );
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment:
            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
        child: WebViewAware(
          child: InfoCustomViewWidget(
            title: 'บันทึกข้อมูลเรียบร้อยแล้ว',
            status: 'success',
          ),
        ),
      );
    },
  );

  await actions.pushReplacement(
    context,
    null,
  );
}

Future updateDraftPoll(BuildContext context) async {
  await FFAppState().tmpPollData.pollReference!.update({
    ...createPollListRecordData(
      subject: FFAppState().tmpPollData.subject,
      detail: FFAppState().tmpPollData.detail,
      isDraft: true,
      updateDate: getCurrentTimestamp,
      maxAnswer: FFAppState().tmpPollData.maxAnswer,
    ),
    ...mapToFirestore(
      {
        'question_list': getQuestionDataListFirestoreData(
          FFAppState().tmpQuestionDataList,
        ),
      },
    ),
  });
  await action_blocks.insertTransactionData(
    context,
    pollReference: FFAppState().tmpPollData.pollReference,
    type: 'แก้ไขแบบร่าง',
    credit: 0,
  );
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment:
            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
        child: WebViewAware(
          child: InfoCustomViewWidget(
            title: 'บันทึกข้อมูลเรียบร้อยแล้ว',
            status: 'success',
          ),
        ),
      );
    },
  );

  await actions.pushReplacement(
    context,
    null,
  );
}

Future updateDraftToReal(BuildContext context) async {
  PollListRecord? pollResult;

  await FFAppState().tmpPollData.pollReference!.update({
    ...createPollListRecordData(
      subject: FFAppState().tmpPollData.subject,
      detail: FFAppState().tmpPollData.detail,
      isDraft: false,
      updateDate: getCurrentTimestamp,
      maxAnswer: FFAppState().tmpPollData.maxAnswer,
      editExpire: functions.getNextTime(60, getCurrentTimestamp),
    ),
    ...mapToFirestore(
      {
        'question_list': getQuestionDataListFirestoreData(
          FFAppState().tmpQuestionDataList,
        ),
      },
    ),
  });
  await action_blocks.insertTransactionData(
    context,
    pollReference: FFAppState().tmpPollData.pollReference,
    type: 'สร้าง',
    credit: functions.getCreditRate(FFAppState().tmpPollData.maxAnswer,
        FFAppState().customerData.creditRate.toList()),
  );
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment:
            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
        child: WebViewAware(
          child: InfoCustomViewWidget(
            title: 'บันทึกข้อมูลเรียบร้อยแล้ว',
            status: 'success',
            detail:
                'คุณสามารถแก้ไขแบบสำรวจนี้ได้ภายใน 1 ชั่วโมงหลังจากการสร้าง หลังจากนั้นจะไม่สามารถแก้ไขได้อีก',
          ),
        ),
      );
    },
  );

  pollResult = await PollListRecord.getDocumentOnce(
      FFAppState().tmpPollData.pollReference!);
  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: false,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return WebViewAware(
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: QRCodePollViewWidget(
            pollDocument: pollResult!,
          ),
        ),
      );
    },
  );

  await actions.pushReplacement(
    context,
    null,
  );
}
