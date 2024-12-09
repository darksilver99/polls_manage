import '/backend/backend.dart';
import '/components/back_button_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'poll_summary_page_model.dart';
export 'poll_summary_page_model.dart';

class PollSummaryPageWidget extends StatefulWidget {
  const PollSummaryPageWidget({
    super.key,
    required this.pollDocument,
  });

  final PollListRecord? pollDocument;

  @override
  State<PollSummaryPageWidget> createState() => _PollSummaryPageWidgetState();
}

class _PollSummaryPageWidgetState extends State<PollSummaryPageWidget> {
  late PollSummaryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PollSummaryPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.summaryData = await actions.getSummaryData(
        widget!.pollDocument!.reference,
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            wrapWithModel(
              model: _model.backButtonViewModel,
              updateCallback: () => safeSetState(() {}),
              child: BackButtonViewWidget(
                title: 'สรุปผลการตอบ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
