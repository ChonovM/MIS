import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/exam.dart';

class StorageHelper {
  static Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/exams.json');
  }

  static Future<void> saveExams(List<Exam> exams) async {
    final file = await _getLocalFile();
    final jsonData = jsonEncode(exams.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonData);
  }

  static Future<List<Exam>> loadExams() async {
    final file = await _getLocalFile();
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final data = jsonDecode(jsonData) as List;
      return data.map((e) => Exam.fromJson(e)).toList();
    }
    return [];
  }
}
