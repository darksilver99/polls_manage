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

Future<String?> getSummaryData(DocumentReference pollReference) async {
  // Add your function code here!
  final firestore = FirebaseFirestore.instance;

  final pollDoc = await firestore.doc(pollReference.path).get();

  if (!pollDoc.exists) throw Exception('Poll not found');

  final questionList =
      List<Map<String, dynamic>>.from(pollDoc.data()!['question_list'] ?? []);

  final answersQuery = await firestore
      .collection('${pollReference.parent.parent!.path}/answer_list')
      .where('poll_ref', isEqualTo: pollReference)
      .get();

  final allAnswers = answersQuery.docs
      .map((doc) => List<Map<String, dynamic>>.from(doc.data()['answers']))
      .expand((e) => e)
      .toList();

  final results = <String, Map<String, int>>{};

  for (final question in questionList) {
    final topic = question['topic'];
    final type = question['type'];
    final options = question['option_list'] ?? [];

    if (type == 2 || type == 3) {
      // Initialize counts for each option
      results[topic] = {for (var option in options) option: 0};
    }
  }

  for (final answer in allAnswers) {
    final questionType = answer['question_type'];
    final userAnswers = List<String>.from(answer['answer']);

    if (questionType == 2 || questionType == 3) {
      for (final userAnswer in userAnswers) {
        // Find corresponding topic and increment count
        for (final topic in results.keys) {
          if (results[topic]!.containsKey(userAnswer)) {
            results[topic]![userAnswer] =
                (results[topic]![userAnswer] ?? 0) + 1;
          }
        }
      }
    }
  }

  print("results");
  print(results);
  return null;
}
