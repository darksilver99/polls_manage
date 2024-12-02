import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/question_pre_view/question_pre_view_widget.dart';
import '/poll_view/select_type_view/select_type_view_widget.dart';
import '/poll_view/step_view/step_view_widget.dart';
import '/poll_view/topic_form_view/topic_form_view_widget.dart';
import '/poll_view/type_form_view/type_form_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'second_step_page_widget.dart' show SecondStepPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class SecondStepPageModel extends FlutterFlowModel<SecondStepPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - confirmBlock] action in Button widget.
  bool? isConfirm;
  // Model for StepView component.
  late StepViewModel stepViewModel;
  // Stores action output result for [Bottom Sheet - QuestionPreView] action in Container widget.
  String? isEdit;
  // Stores action output result for [Bottom Sheet - TopicFormView] action in Container widget.
  String? topicEdit;
  // Stores action output result for [Bottom Sheet - TypeFormView] action in Container widget.
  List<String>? optionEditList;
  // Stores action output result for [Bottom Sheet - SelectTypeView] action in Button widget.
  int? typeID;
  // Stores action output result for [Bottom Sheet - TopicFormView] action in Button widget.
  String? topic;
  // Stores action output result for [Bottom Sheet - TypeFormView] action in Button widget.
  List<String>? optionList;

  @override
  void initState(BuildContext context) {
    stepViewModel = createModel(context, () => StepViewModel());
  }

  @override
  void dispose() {
    stepViewModel.dispose();
  }
}
