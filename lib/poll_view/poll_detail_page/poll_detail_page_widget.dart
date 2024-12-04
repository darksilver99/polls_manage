import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/checkbox_answer_view/checkbox_answer_view_widget.dart';
import '/poll_view/q_r_code_poll_view/q_r_code_poll_view_widget.dart';
import '/poll_view/radio_answer_view/radio_answer_view_widget.dart';
import '/poll_view/text_field_answer_view/text_field_answer_view_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'poll_detail_page_model.dart';
export 'poll_detail_page_model.dart';

class PollDetailPageWidget extends StatefulWidget {
  const PollDetailPageWidget({
    super.key,
    required this.pollDocument,
  });

  final PollListRecord? pollDocument;

  @override
  State<PollDetailPageWidget> createState() => _PollDetailPageWidgetState();
}

class _PollDetailPageWidgetState extends State<PollDetailPageWidget> {
  late PollDetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PollDetailPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.pollResult =
          await PollListRecord.getDocumentOnce(widget!.pollDocument!.reference);
      if (_model.pollResult != null) {
        FFAppState().tmpAnswerList = [];
        while (_model.tmpAnswerIndex! <
            widget!.pollDocument!.questionList.length) {
          FFAppState().addToTmpAnswerList(AnswerDataStruct(
            answer: [],
            questionType:
                (widget!.pollDocument?.questionList?[_model.tmpAnswerIndex!])
                    ?.type,
          ));
          safeSetState(() {});
          _model.tmpAnswerIndex = _model.tmpAnswerIndex! + 1;
        }
        _model.isLoading = false;
        safeSetState(() {});
      } else {
        await showDialog(
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: WebViewAware(
                child: GestureDetector(
                  onTap: () => FocusScope.of(dialogContext).unfocus(),
                  child: InfoCustomViewWidget(
                    title: 'ไม่มีรายการนี้แล้ว',
                    status: 'error',
                  ),
                ),
              ),
            );
          },
        );

        await actions.pushReplacement(
          context,
          null,
        );
      }
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

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (currentUserEmail ==
                          FFAppState().customerData.customerName)
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 8.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            useSafeArea: true,
                                            context: context,
                                            builder: (context) {
                                              return WebViewAware(
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: QRCodePollViewWidget(
                                                      pollDocument:
                                                          _model.pollResult!,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                        text: 'QR Code',
                                        icon: Icon(
                                          Icons.qr_code_rounded,
                                          size: 22.0,
                                        ),
                                        options: FFButtonOptions(
                                          height: 32.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 8.0, 0.0),
                                          iconAlignment: IconAlignment.end,
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
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Builder(
                                        builder: (context) => InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: WebViewAware(
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(
                                                                  dialogContext)
                                                              .unfocus(),
                                                      child:
                                                          InfoCustomViewWidget(
                                                        title:
                                                            'คำเตือน: การแก้ไขอาจทำให้ข้อมูลคำตอบที่ได้รับก่อนหน้านี้ผิดพลาดหรือไม่สอดคล้องกับคำถามที่แก้ไขใหม่ กรุณาตรวจสอบให้แน่ใจก่อนดำเนินการแก้ไข เพื่อป้องกันผลกระทบต่อข้อมูลที่รวบรวมไว้แล้ว',
                                                        status: 'error',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'แก้ไข',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Kanit',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.safePop();
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 32.0,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_model.isLoading)
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    valueOrDefault<String>(
                                      _model.pollResult?.subject,
                                      '-',
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Kanit',
                                          fontSize: 22.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            if (_model.pollResult?.detail != null &&
                                _model.pollResult?.detail != '')
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      valueOrDefault<String>(
                                        _model.pollResult?.detail,
                                        '-',
                                      ),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Kanit',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 8.0, 0.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      functions.dateTh(_model
                                                  .pollResult?.startDate) !=
                                              functions.dateTh(
                                                  _model.pollResult?.endDate)
                                          ? 'ระยะเวลา ${valueOrDefault<String>(
                                              functions.dateTh(
                                                  _model.pollResult?.startDate),
                                              '-',
                                            )} - ${valueOrDefault<String>(
                                              functions.dateTh(
                                                  _model.pollResult?.endDate),
                                              '-',
                                            )}'
                                          : 'ระยะเวลา ${valueOrDefault<String>(
                                              functions.dateTh(
                                                  _model.pollResult?.startDate),
                                              '-',
                                            )}',
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Kanit',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: Builder(
                                builder: (context) {
                                  final questionListView = _model
                                          .pollResult?.questionList
                                          ?.toList() ??
                                      [];

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children:
                                        List.generate(questionListView.length,
                                            (questionListViewIndex) {
                                      final questionListViewItem =
                                          questionListView[
                                              questionListViewIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      questionListViewItem
                                                          .topic,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Kanit',
                                                            fontSize: 20.0,
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 16.0),
                                              child: Builder(
                                                builder: (context) {
                                                  if (questionListViewItem
                                                          .type ==
                                                      1) {
                                                    return wrapWithModel(
                                                      model: _model
                                                          .textFieldAnswerViewModels
                                                          .getModel(
                                                        questionListViewIndex
                                                            .toString(),
                                                        questionListViewIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          TextFieldAnswerViewWidget(
                                                        key: Key(
                                                          'Keywrz_${questionListViewIndex.toString()}',
                                                        ),
                                                        itemIndex:
                                                            questionListViewIndex,
                                                      ),
                                                    );
                                                  } else if (questionListViewItem
                                                          .type ==
                                                      2) {
                                                    return RadioAnswerViewWidget(
                                                      key: Key(
                                                          'Key7dj_${questionListViewIndex}_of_${questionListView.length}'),
                                                      optionList:
                                                          questionListViewItem
                                                              .optionList,
                                                      itemIndex:
                                                          questionListViewIndex,
                                                    );
                                                  } else {
                                                    return Container(
                                                      child:
                                                          CheckboxAnswerViewWidget(
                                                        key: Key(
                                                            'Key61g_${questionListViewIndex}_of_${questionListView.length}'),
                                                        itemIndex:
                                                            questionListViewIndex,
                                                        optionList:
                                                            questionListViewItem
                                                                .optionList,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                            Divider(
                                              thickness: 2.0,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ),
                            Builder(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 32.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await AnswerListRecord.createDoc(widget!
                                            .pollDocument!.parentReference)
                                        .set({
                                      ...createAnswerListRecordData(
                                        createDate: getCurrentTimestamp,
                                        pollRef:
                                            widget!.pollDocument?.reference,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'answers':
                                              getAnswerDataListFirestoreData(
                                            FFAppState().tmpAnswerList,
                                          ),
                                        },
                                      ),
                                    });
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
                                            child: GestureDetector(
                                              onTap: () =>
                                                  FocusScope.of(dialogContext)
                                                      .unfocus(),
                                              child: InfoCustomViewWidget(
                                                title: 'ส่งข้อมูลเรียบร้อยแล้ว',
                                                status: 'success',
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                    context.safePop();
                                  },
                                  text: 'ส่งข้อมูล',
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
                          ]
                              .addToStart(SizedBox(height: 8.0))
                              .addToEnd(SizedBox(height: 32.0)),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
