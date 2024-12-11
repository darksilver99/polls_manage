import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/back_button_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'poll_summary_page_widget.dart' show PollSummaryPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PollSummaryPageModel extends FlutterFlowModel<PollSummaryPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getSummaryData] action in PollSummaryPage widget.
  List<SummaryDataStruct>? summaryData;
  // Model for BackButtonView component.
  late BackButtonViewModel backButtonViewModel;

  @override
  void initState(BuildContext context) {
    backButtonViewModel = createModel(context, () => BackButtonViewModel());
  }

  @override
  void dispose() {
    backButtonViewModel.dispose();
  }
}
