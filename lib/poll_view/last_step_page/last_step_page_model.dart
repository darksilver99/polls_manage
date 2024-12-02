import '/backend/schema/structs/index.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/poll_pre_view/poll_pre_view_widget.dart';
import '/poll_view/step_view/step_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'last_step_page_widget.dart' show LastStepPageWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class LastStepPageModel extends FlutterFlowModel<LastStepPageWidget> {
  ///  Local state fields for this page.

  DateTime? startDate;

  DateTime? endDate;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - confirmBlock] action in Button widget.
  bool? isConfirm;
  // Model for StepView component.
  late StepViewModel stepViewModel;
  DateTime? datePicked1;
  DateTime? datePicked2;

  @override
  void initState(BuildContext context) {
    stepViewModel = createModel(context, () => StepViewModel());
  }

  @override
  void dispose() {
    stepViewModel.dispose();
  }
}
