// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:excel/excel.dart';
import 'package:excel/excel.dart' as exBorder;
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:polls_manage/custom_toon/custom_toon.dart';

Future<String> exportExcel(DocumentReference pollReference) async {
  // Add your function code here!

  bool isGranted = false;
  if (Platform.isAndroid) {
    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    if (int.parse(info.version.release) >= 13) {
      isGranted = true;
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        isGranted = true;
      }
    }
  } else {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      isGranted = true;
    }
  }

  if (!isGranted) {
    return 'No Data';
  }

  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];

  CellStyle cellStyle = CellStyle(
    backgroundColorHex: ExcelColor.fromHexString("#1AFF1A"),
    horizontalAlign: HorizontalAlign.Center,
    bold: true,
    leftBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
    rightBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
    topBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
    bottomBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
  );

  // Add headers
  List<String> header = await getHeader(pollReference);

  if (header.isEmpty) {
    return 'No Data';
  }

  header.add("วันที่ตอบ");

  // title
  var cell =
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
  cell.value = TextCellValue(
      'รายงานสรุปคำตอบของแบบสำรวจทั้งหมด ข้อมูล ณ วันที่ ${functions.dateTh(getCurrentTimestamp)}');
  cell.cellStyle = CellStyle(fontSize: 22, bold: true);

  for (var i = 0; i < header.length; i++) {
    var cell = sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 1));
    cell.value = TextCellValue(header[i]);
    cell.cellStyle = cellStyle;
  }

  // body
  QuerySnapshot<Map<String, dynamic>> dataList = await FirebaseFirestore
      .instance
      .collection("${FFAppState().customerData.customerRef!.path}/answer_list")
      .where("poll_ref", isEqualTo: pollReference)
      .orderBy("create_date", descending: true)
      .get();

  if (dataList.size == 0) {
    return "No Data";
  }

  for (int i = 0; i < dataList.size; i++) {
    var dataRecord = dataList.docs[i].data();
    List<dynamic> answersList = dataRecord["answers"];
    print(answersList.runtimeType);
    print(answersList);
    for (int j = 0; j < answersList.length; j++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 2))
        ..value = TextCellValue("${answersList[j]["answer"].join(',')}")
        ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      if (j == (answersList.length - 1)) {
        sheetObject.cell(CellIndex.indexByColumnRow(
            columnIndex: answersList.length, rowIndex: i + 2))
          ..value = TextCellValue(
              "${functions.dateTimeTh(dataRecord["create_date"].toDate())}")
          ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);
      }
    }
  }

  // Auto-size columns
  for (int col = 0; col < header.length; col++) {
    //sheetObject.setColumnWidth(col, 2000);
    sheetObject.setDefaultColumnWidth(30);
    //sheetObject.setColumnAutoFit(col);
  }

  Directory dir = await getApplicationDocumentsDirectory();
  //Directory dir = Directory('/storage/emulated/0/Download');
  List<int>? fileBytes = excel.save();
  var path = File(
      '${dir.path}/รายงานสรุปคำตอบของแบบสำรวจทั้งหมดข้อมูลวันที่${functions.dateTh(getCurrentTimestamp)}.xlsx')
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  print(path);

  return path.path;
}
