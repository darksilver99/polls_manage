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

import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

Future<String> exportPDF(PollListRecord pollReference) async {
  // Create a new PDF document
  final pdf = pw.Document();

  final fontData = await rootBundle.load('assets/fonts/THSarabunNew.ttf');
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());

  // Create the PDF page
  try {
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          // Poll subject and details
          pw.Header(
            level: 0,
            child: pw.Text(
              pollReference.subject,
              style: pw.TextStyle(
                  fontSize: 24, fontWeight: pw.FontWeight.bold, font: ttf),
            ),
          ),

          // Poll details
          pw.Paragraph(
            text: pollReference.detail,
            style: pw.TextStyle(fontSize: 14, font: ttf),
          ),
          pw.SizedBox(height: 20),

          // Iterate through each survey question
          ...pollReference.questionList.map((question) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Group question and answer together to avoid splitting across pages
                pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Question topic
                      pw.Text(
                        question.topic ?? '',
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf),
                      ),
                      pw.SizedBox(height: 10),

                      // Render different question types
                      _renderQuestionType(question, ttf),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),
              ],
            );
          }).toList(),
        ],
        // Add padding and prevent splitting content
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        footer: (context) => pw.Text(
          'หน้าที่ ${context.pageNumber} จาก ${context.pagesCount}',
          style: pw.TextStyle(font: ttf, fontSize: 12),
          textAlign: pw.TextAlign.center,
        ),
      ),
    );
  } catch (e) {
    if ((e.runtimeType.toString() == "TooManyPagesException")) {
      return "error Many answer";
    }
    return "error ${e.toString()}";
  }

  // Save the PDF
  Directory dir = await getApplicationDocumentsDirectory();
  final filename = 'Easy_poll.pdf';
  final file = File('${dir.path}/$filename');
  await file.writeAsBytes(await pdf.save());

  return file.path;
}

// Helper method to render different question types
pw.Widget _renderQuestionType(QuestionDataStruct question, pw.Font ttf) {
  switch (question.type) {
    case 1: // Open text input
      return pw.Container(
        width: double.infinity,
        height: 100,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
        ),
      );

    case 2: // Single choice
      return pw.Wrap(
        spacing: 10,
        runSpacing: 5,
        children: question.optionList?.map<pw.Widget>((option) {
              return pw.Row(
                children: [
                  pw.Container(
                    width: 20,
                    height: 20,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                      shape: pw.BoxShape.circle,
                    ),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(option ?? '', style: pw.TextStyle(font: ttf)),
                ],
              );
            }).toList() ??
            [],
      );

    case 3: // Multiple choice
      return pw.Wrap(
        spacing: 10,
        runSpacing: 5,
        children: question.optionList?.map<pw.Widget>((option) {
              return pw.Row(
                children: [
                  pw.Container(
                    width: 20,
                    height: 20,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(option ?? '', style: pw.TextStyle(font: ttf)),
                ],
              );
            }).toList() ??
            [],
      );

    default:
      return pw.Text('ประเภทคำถามไม่ถูกต้อง');
  }
}
