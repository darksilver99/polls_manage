import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';


Future<String?> getSaveAndGetImagePath(WidgetsToImageController controller) async {
  final bytes = await controller.capture();
  String base64Image = base64Encode(bytes!);

  final Directory tempDir = await getTemporaryDirectory();
  final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  final String tempPath = '${tempDir.path}/qr_code_$timestamp.png';
  await File(tempPath).writeAsBytes(base64Decode(base64Image));

  return tempPath;
}


Future<List<String>> getHeader(DocumentReference pollReference) async {

  try {
    var rs = await pollReference.get();
    var data = rs.data() as Map<String, dynamic>?;
    if (data == null || !data.containsKey('question_list')) {
      return [];
    }

    var questionList = data['question_list'] as List<dynamic>;
    var topics = questionList
        .where((question) => question is Map && question.containsKey('topic'))
        .map((question) => question['topic'] as String)
        .toList();

    return topics;
  } catch (e) {
    print("Error: $e");
    return [];
  }

}