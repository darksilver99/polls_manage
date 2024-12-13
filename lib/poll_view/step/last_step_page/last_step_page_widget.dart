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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'last_step_page_model.dart';
export 'last_step_page_model.dart';

class LastStepPageWidget extends StatefulWidget {
  const LastStepPageWidget({super.key});

  @override
  State<LastStepPageWidget> createState() => _LastStepPageWidgetState();
}

class _LastStepPageWidgetState extends State<LastStepPageWidget> {
  late LastStepPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LastStepPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
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
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.draftViewModel,
                updateCallback: () => safeSetState(() {}),
                child: DraftViewWidget(
                  showDraftButton: true,
                ),
              ),
              wrapWithModel(
                model: _model.stepViewModel,
                updateCallback: () => safeSetState(() {}),
                child: StepViewWidget(
                  currentStep: 3,
                ),
              ),
              if (!_model.isLoading)
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                      child: Builder(
                        builder: (context) {
                          final creditRateView =
                              FFAppState().customerData.creditRate.toList();

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(creditRateView.length,
                                (creditRateViewIndex) {
                              final creditRateViewItem =
                                  creditRateView[creditRateViewIndex];
                              return Builder(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (!((FFAppState().tmpPollData.isDraft ==
                                            false) &&
                                        (FFAppState()
                                                .tmpPollData
                                                .pollReference !=
                                            null))) {
                                      FFAppState().updateTmpPollDataStruct(
                                        (e) => e
                                          ..maxAnswer =
                                              creditRateViewItem.totalAnswer,
                                      );
                                      safeSetState(() {});
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: WebViewAware(
                                              child: InfoCustomViewWidget(
                                                title:
                                                    'ไม่สามารถเปลี่ยนแปลงจำนวนผู้ตอบได้แล้ว',
                                                status: 'error',
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    creditRateViewItem.subject,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Kanit',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    ' ${creditRateViewItem.credit.toString()} เครดิต',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Kanit',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              if (creditRateViewItem
                                                      .totalAnswer ==
                                                  FFAppState()
                                                      .tmpPollData
                                                      .maxAnswer) {
                                                return Icon(
                                                  Icons.check_circle_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 32.0,
                                                );
                                              } else {
                                                return Icon(
                                                  Icons
                                                      .radio_button_off_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 32.0,
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).divide(SizedBox(height: 8.0)),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 6.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.safePop();
                              },
                              text: 'กลับ',
                              options: FFButtonOptions(
                                height: 57.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Kanit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Builder(
                              builder: (context) => FFButtonWidget(
                                onPressed: () async {
                                  await actions.hideKeyBoard(
                                    context,
                                  );
                                  if (FFAppState().tmpPollData.maxAnswer != 0) {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) {
                                        return WebViewAware(
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: PollPreViewWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(
                                        () => _model.isSave = value));

                                    if ((_model.isSave != null &&
                                            _model.isSave != '') &&
                                        (_model.isSave == 'save')) {
                                      if (FFAppState().tmpPollData.isDraft) {
                                        await action_blocks
                                            .updateDraftToReal(context);
                                      } else {
                                        if (FFAppState()
                                                .tmpPollData
                                                .pollReference !=
                                            null) {
                                          await action_blocks
                                              .updatePoll(context);
                                        } else {
                                          await action_blocks
                                              .insertPoll(context);
                                        }
                                      }
                                    }
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: WebViewAware(
                                            child: InfoCustomViewWidget(
                                              title: 'กรุณาเลือกจำนวนผู้ตอบ',
                                              status: 'warning',
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }

                                  safeSetState(() {});
                                },
                                text: 'ดูตัวอย่าง',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 57.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Kanit',
                                        color: Colors.white,
                                        fontSize: 28.0,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ]
                .addToStart(SizedBox(height: 8.0))
                .addToEnd(SizedBox(height: 180.0)),
          ),
        ),
      ),
    );
  }
}
