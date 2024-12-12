import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/poll_component/draft_view/draft_view_widget.dart';
import '/poll_view/poll_component/step_view/step_view_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'first_step_page_widget.dart' show FirstStepPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FirstStepPageModel extends FlutterFlowModel<FirstStepPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for DraftView component.
  late DraftViewModel draftViewModel;
  // Model for StepView component.
  late StepViewModel stepViewModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  @override
  void initState(BuildContext context) {
    draftViewModel = createModel(context, () => DraftViewModel());
    stepViewModel = createModel(context, () => StepViewModel());
    textController1Validator = _textController1Validator;
  }

  @override
  void dispose() {
    draftViewModel.dispose();
    stepViewModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
