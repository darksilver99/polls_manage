import '/backend/schema/structs/index.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/poll_component/draft_view/draft_view_widget.dart';
import '/poll_view/poll_component/poll_pre_view/poll_pre_view_widget.dart';
import '/poll_view/poll_component/step_view/step_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'last_step_page_widget.dart' show LastStepPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class LastStepPageModel extends FlutterFlowModel<LastStepPageWidget> {
  ///  Local state fields for this page.

  DateTime? startDate;

  DateTime? endDate;

  bool isLoading = true;

  ///  State fields for stateful widgets in this page.

  // Model for DraftView component.
  late DraftViewModel draftViewModel;
  // Model for StepView component.
  late StepViewModel stepViewModel;
  // Stores action output result for [Bottom Sheet - PollPreView] action in Button widget.
  String? isSave;

  @override
  void initState(BuildContext context) {
    draftViewModel = createModel(context, () => DraftViewModel());
    stepViewModel = createModel(context, () => StepViewModel());
  }

  @override
  void dispose() {
    draftViewModel.dispose();
    stepViewModel.dispose();
  }
}
