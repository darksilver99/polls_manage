import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/back_button_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/poll_component/chart_view/chart_view_widget.dart';
import '/poll_view/poll_component/poll_answer_list_view/poll_answer_list_view_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
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
      _model.isLoading = false;
      safeSetState(() {});
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
            if (!_model.isLoading)
              Expanded(
                child: Builder(
                  builder: (context) {
                    final summaryList = _model.summaryData?.toList() ?? [];

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(summaryList.length,
                            (summaryListIndex) {
                          final summaryListItem = summaryList[summaryListIndex];
                          return Builder(
                            builder: (context) {
                              if (summaryListItem.type == 1) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 8.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 4.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                valueOrDefault<String>(
                                                  summaryListItem.question,
                                                  '-',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Kanit',
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 8.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
                                              useSafeArea: true,
                                              context: context,
                                              builder: (context) {
                                                return WebViewAware(
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child:
                                                        PollAnswerListViewWidget(
                                                      summaryData:
                                                          summaryListItem,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          text: 'ดูคำตอบ',
                                          options: FFButtonOptions(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Kanit',
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 2.0,
                                        indent: 16.0,
                                        endIndent: 16.0,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  child: wrapWithModel(
                                    model: _model.chartViewModels.getModel(
                                      summaryListIndex.toString(),
                                      summaryListIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: ChartViewWidget(
                                      key: Key(
                                        'Key81v_${summaryListIndex.toString()}',
                                      ),
                                      summaryData: summaryListItem,
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
