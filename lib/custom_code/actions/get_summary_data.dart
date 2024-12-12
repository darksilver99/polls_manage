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

Future<List<SummaryDataStruct>?> getSummaryData(
    DocumentReference pollReference) async {
  // Add your function code here!
  final firestore = FirebaseFirestore.instance;

  // ดึงข้อมูลคำถามจาก Poll
  final pollDoc = await firestore.doc(pollReference.path).get();

  if (!pollDoc.exists) throw Exception('Poll not found');

  final questionList =
      List<Map<String, dynamic>>.from(pollDoc.data()!['question_list'] ?? []);

  // ดึงข้อมูลคำตอบจาก Answer List
  final answersQuery = await firestore
      .collection('${pollReference.parent.parent!.path}/answer_list')
      .where('poll_ref', isEqualTo: pollReference)
      .get();

  final allAnswers = answersQuery.docs
      .map((doc) => List<Map<String, dynamic>>.from(doc.data()['answers']))
      .expand((e) => e)
      .toList();

  // สร้างผลลัพธ์ในรูปแบบ SummaryDataStruct
  List<SummaryDataStruct> summaryDataList = [];

  for (final question in questionList) {
    final topic = question['topic'];
    final type = question['type'];
    final id = question['topic_id'];

    List<String> options = List<String>.from(question['option_list'] ?? []);

    // สร้างคำตอบทั้งหมดในคำถามนี้เป็น 0 ก่อน
    List<SummaryAnswerDataStruct> answerList = options.map((option) {
      return SummaryAnswerDataStruct(
        answer: option,
        total: 0,
        type: type,
      );
    }).toList();

    // นับจำนวนคำตอบจากทุกๆ answer
    for (final answer in allAnswers) {
      final questionType = answer['question_type'];
      final topicID = answer['topic_id'];
      final userAnswers = List<String>.from(answer['answer']);

      if (questionType == type && id == topicID) {
        for (final userAnswer in userAnswers) {
          for (final answerData in answerList) {
            if (answerData.answer == userAnswer) {
              answerData.total++;
            }
          }
        }
      }
    }

    // เพิ่มข้อมูลลงใน summaryDataList
    summaryDataList.add(SummaryDataStruct(
      question: topic,
      answers: answerList,
    ));
  }

  summaryDataList.forEach((e) {
    print(e.question);
    print(e.answers);
    print("-----------");
  });
  return summaryDataList;
}
