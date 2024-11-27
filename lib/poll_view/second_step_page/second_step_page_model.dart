import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/step_view/step_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'second_step_page_widget.dart' show SecondStepPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SecondStepPageModel extends FlutterFlowModel<SecondStepPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - confirmBlock] action in Button widget.
  bool? isConfirm;
  // Model for StepView component.
  late StepViewModel stepViewModel;

  @override
  void initState(BuildContext context) {
    stepViewModel = createModel(context, () => StepViewModel());
  }

  @override
  void dispose() {
    stepViewModel.dispose();
  }
}
