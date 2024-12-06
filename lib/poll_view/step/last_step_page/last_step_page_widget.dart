import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/draft_view/draft_view_widget.dart';
import '/poll_view/poll_pre_view/poll_pre_view_widget.dart';
import '/poll_view/q_r_code_poll_view/q_r_code_poll_view_widget.dart';
import '/poll_view/step_view/step_view_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
      _model.isLoading = true;
      safeSetState(() {});
      if (FFAppState().tmpPollData.startDate != null) {
        _model.startDate = FFAppState().tmpPollData.startDate;
        if (FFAppState().tmpPollData.endDate != null) {
          _model.endDate = FFAppState().tmpPollData.endDate;
        }
      }
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
                child: DraftViewWidget(),
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
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          final _datePicked1Date = await showDatePicker(
                            context: context,
                            initialDate: ((_model.startDate != null
                                    ? _model.startDate
                                    : getCurrentTimestamp) ??
                                DateTime.now()),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2050),
                            builder: (context, child) {
                              return wrapInMaterialDatePickerTheme(
                                context,
                                child!,
                                headerBackgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                                headerForegroundColor:
                                    FlutterFlowTheme.of(context).info,
                                headerTextStyle: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .override(
                                      fontFamily: 'Kanit',
                                      fontSize: 32.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                pickerBackgroundColor:
                                    FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                pickerForegroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                selectedDateTimeBackgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                                selectedDateTimeForegroundColor:
                                    FlutterFlowTheme.of(context).info,
                                actionButtonForegroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 24.0,
                              );
                            },
                          );

                          if (_datePicked1Date != null) {
                            safeSetState(() {
                              _model.datePicked1 = DateTime(
                                _datePicked1Date.year,
                                _datePicked1Date.month,
                                _datePicked1Date.day,
                              );
                            });
                          }
                          if (_model.datePicked1 != null) {
                            _model.startDate = _model.datePicked1;
                            _model.endDate = null;
                            FFAppState().updateTmpPollDataStruct(
                              (e) => e
                                ..startDate = _model.startDate
                                ..endDate = null,
                            );
                            safeSetState(() {});
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 57.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 16.0, 0.0),
                                child: Container(
                                  width: 57.0,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.calendar_month_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 36.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        valueOrDefault<String>(
                                          _model.startDate != null
                                              ? functions
                                                  .dateTh(_model.startDate)
                                              : 'เลือกวันที่เริ่มต้น',
                                          '-',
                                        ),
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_model.startDate != null)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 16.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            final _datePicked2Date = await showDatePicker(
                              context: context,
                              initialDate: ((_model.endDate != null
                                      ? _model.endDate
                                      : _model.startDate) ??
                                  DateTime.now()),
                              firstDate: (_model.startDate ?? DateTime(1900)),
                              lastDate: DateTime(2050),
                              builder: (context, child) {
                                return wrapInMaterialDatePickerTheme(
                                  context,
                                  child!,
                                  headerBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  headerForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  headerTextStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: 'Kanit',
                                        fontSize: 32.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  pickerBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                  pickerForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedDateTimeBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  selectedDateTimeForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  actionButtonForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  iconSize: 24.0,
                                );
                              },
                            );

                            if (_datePicked2Date != null) {
                              safeSetState(() {
                                _model.datePicked2 = DateTime(
                                  _datePicked2Date.year,
                                  _datePicked2Date.month,
                                  _datePicked2Date.day,
                                );
                              });
                            }
                            if (_model.datePicked2 != null) {
                              _model.endDate =
                                  functions.getEndDayTime(_model.datePicked2!);
                              FFAppState().updateTmpPollDataStruct(
                                (e) => e..endDate = _model.endDate,
                              );
                              safeSetState(() {});
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 57.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: Container(
                                    width: 57.0,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.calendar_month_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 36.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          valueOrDefault<String>(
                                            _model.endDate != null
                                                ? functions
                                                    .dateTh(_model.endDate)
                                                : 'เลือกวันที่สิ้นสุด',
                                            '-',
                                          ),
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
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
                              ],
                            ),
                          ),
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
                                  if ((_model.startDate != null) &&
                                      (_model.endDate != null)) {
                                    FFAppState().updateTmpPollDataStruct(
                                      (e) => e
                                        ..startDate = _model.startDate
                                        ..endDate = _model.endDate,
                                    );
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
                                      var pollListRecordReference1 =
                                          PollListRecord.createDoc(FFAppState()
                                              .customerData
                                              .customerRef!);
                                      await pollListRecordReference1.set({
                                        ...createPollListRecordData(
                                          createDate: getCurrentTimestamp,
                                          status: 1,
                                          startDate: FFAppState()
                                              .tmpPollData
                                              .startDate,
                                          endDate:
                                              FFAppState().tmpPollData.endDate,
                                          subject:
                                              FFAppState().tmpPollData.subject,
                                          detail:
                                              FFAppState().tmpPollData.detail,
                                          isDraft: false,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'question_list':
                                                getQuestionDataListFirestoreData(
                                              FFAppState()
                                                  .tmpPollData
                                                  .questionList,
                                            ),
                                          },
                                        ),
                                      });
                                      _model.insertedPoll =
                                          PollListRecord.getDocumentFromData({
                                        ...createPollListRecordData(
                                          createDate: getCurrentTimestamp,
                                          status: 1,
                                          startDate: FFAppState()
                                              .tmpPollData
                                              .startDate,
                                          endDate:
                                              FFAppState().tmpPollData.endDate,
                                          subject:
                                              FFAppState().tmpPollData.subject,
                                          detail:
                                              FFAppState().tmpPollData.detail,
                                          isDraft: false,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'question_list':
                                                getQuestionDataListFirestoreData(
                                              FFAppState()
                                                  .tmpPollData
                                                  .questionList,
                                            ),
                                          },
                                        ),
                                      }, pollListRecordReference1);

                                      await _model.insertedPoll!.reference
                                          .update(createPollListRecordData(
                                        pollPath:
                                            'customer_list/${FFAppState().customerData.customerRef?.id}/poll_list/${_model.insertedPoll?.reference.id}',
                                      ));
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
                                                    'บันทึกข้อมูลเรียบร้อยแล้ว',
                                                status: 'success',
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      _model.pollResult =
                                          await PollListRecord.getDocumentOnce(
                                              _model.insertedPoll!.reference);
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
                                              child: QRCodePollViewWidget(
                                                pollDocument:
                                                    _model.pollResult!,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      await actions.pushReplacement(
                                        context,
                                        null,
                                      );
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
                                              title:
                                                  'กรุณาเลือกวันที่เริ่มต้น-สิ้นสุด',
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
