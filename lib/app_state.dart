import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _currentDate = prefs.containsKey('ff_currentDate')
          ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt('ff_currentDate')!)
          : _currentDate;
    });
    _safeInit(() {
      _isSkipExpireAlert =
          prefs.getBool('ff_isSkipExpireAlert') ?? _isSkipExpireAlert;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _appVersion = '';
  String get appVersion => _appVersion;
  set appVersion(String value) {
    _appVersion = value;
  }

  int _appBuildVersion = 0;
  int get appBuildVersion => _appBuildVersion;
  set appBuildVersion(int value) {
    _appBuildVersion = value;
  }

  ConfigDataStruct _configData = ConfigDataStruct();
  ConfigDataStruct get configData => _configData;
  set configData(ConfigDataStruct value) {
    _configData = value;
  }

  void updateConfigDataStruct(Function(ConfigDataStruct) updateFn) {
    updateFn(_configData);
  }

  CustomerDataStruct _customerData = CustomerDataStruct();
  CustomerDataStruct get customerData => _customerData;
  set customerData(CustomerDataStruct value) {
    _customerData = value;
  }

  void updateCustomerDataStruct(Function(CustomerDataStruct) updateFn) {
    updateFn(_customerData);
  }

  DateTime? _currentDate = DateTime.fromMillisecondsSinceEpoch(785923200000);
  DateTime? get currentDate => _currentDate;
  set currentDate(DateTime? value) {
    _currentDate = value;
    value != null
        ? prefs.setInt('ff_currentDate', value.millisecondsSinceEpoch)
        : prefs.remove('ff_currentDate');
  }

  bool _isSkipExpireAlert = false;
  bool get isSkipExpireAlert => _isSkipExpireAlert;
  set isSkipExpireAlert(bool value) {
    _isSkipExpireAlert = value;
    prefs.setBool('ff_isSkipExpireAlert', value);
  }

  List<QuestionDataStruct> _tmpQuestionDataList = [];
  List<QuestionDataStruct> get tmpQuestionDataList => _tmpQuestionDataList;
  set tmpQuestionDataList(List<QuestionDataStruct> value) {
    _tmpQuestionDataList = value;
  }

  void addToTmpQuestionDataList(QuestionDataStruct value) {
    tmpQuestionDataList.add(value);
  }

  void removeFromTmpQuestionDataList(QuestionDataStruct value) {
    tmpQuestionDataList.remove(value);
  }

  void removeAtIndexFromTmpQuestionDataList(int index) {
    tmpQuestionDataList.removeAt(index);
  }

  void updateTmpQuestionDataListAtIndex(
    int index,
    QuestionDataStruct Function(QuestionDataStruct) updateFn,
  ) {
    tmpQuestionDataList[index] = updateFn(_tmpQuestionDataList[index]);
  }

  void insertAtIndexInTmpQuestionDataList(int index, QuestionDataStruct value) {
    tmpQuestionDataList.insert(index, value);
  }

  PollDataStruct _tmpPollData = PollDataStruct.fromSerializableMap(
      jsonDecode('{\"question_list\":\"[]\",\"is_draft\":\"false\"}'));
  PollDataStruct get tmpPollData => _tmpPollData;
  set tmpPollData(PollDataStruct value) {
    _tmpPollData = value;
  }

  void updateTmpPollDataStruct(Function(PollDataStruct) updateFn) {
    updateFn(_tmpPollData);
  }

  List<AnswerDataStruct> _tmpAnswerList = [];
  List<AnswerDataStruct> get tmpAnswerList => _tmpAnswerList;
  set tmpAnswerList(List<AnswerDataStruct> value) {
    _tmpAnswerList = value;
  }

  void addToTmpAnswerList(AnswerDataStruct value) {
    tmpAnswerList.add(value);
  }

  void removeFromTmpAnswerList(AnswerDataStruct value) {
    tmpAnswerList.remove(value);
  }

  void removeAtIndexFromTmpAnswerList(int index) {
    tmpAnswerList.removeAt(index);
  }

  void updateTmpAnswerListAtIndex(
    int index,
    AnswerDataStruct Function(AnswerDataStruct) updateFn,
  ) {
    tmpAnswerList[index] = updateFn(_tmpAnswerList[index]);
  }

  void insertAtIndexInTmpAnswerList(int index, AnswerDataStruct value) {
    tmpAnswerList.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
