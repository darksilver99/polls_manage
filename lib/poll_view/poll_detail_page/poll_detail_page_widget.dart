import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/poll_component/checkbox_answer_view/checkbox_answer_view_widget.dart';
import '/poll_view/poll_component/radio_answer_view/radio_answer_view_widget.dart';
import '/poll_view/poll_component/text_field_answer_view/text_field_answer_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
            questionType: (widget!.pollDocument?.questionList
                    ?.elementAtOrNull(_model.tmpAnswerIndex!))
                ?.type,
            topicId: (widget!.pollDocument?.questionList
                    ?.elementAtOrNull(_model.tmpAnswerIndex!))
                ?.topicId,
          ));
          safeSetState(() {});
          _model.tmpAnswerIndex = _model.tmpAnswerIndex! + 1;
          _model.addToPassList(true);
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
                  onTap: () {
                    FocusScope.of(dialogContext).unfocus();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
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
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: WillPopScope(
          onWillPop: () async => false,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.isConfirm = await action_blocks.confirmBlock(
                              context,
                              title: 'ต้องการออกจากหน้านี้?',
                              detail: 'ระบบจะยังไม่ไม่ถึงข้อมูล',
                            );
                            if (_model.isConfirm!) {
                              context.safePop();
                            }

                            safeSetState(() {});
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
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
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Kanit',
                                            fontSize: 24.0,
                                            letterSpacing: 0.0,
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Kanit',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              Divider(
                                thickness: 2.0,
                                color: FlutterFlowTheme.of(context).alternate,
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (!_model.passList
                                                        .elementAtOrNull(
                                                            questionListViewIndex)!)
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    4.0,
                                                                    0.0),
                                                        child: Icon(
                                                          Icons.error_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          size: 18.0,
                                                        ),
                                                      ),
                                                    Expanded(
                                                      child: Text(
                                                        questionListViewItem
                                                            .topic,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Kanit',
                                                              fontSize: 20.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
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
                                      _model.tmpAnswerIndex = 0;
                                      while (_model.tmpAnswerIndex! <
                                          FFAppState().tmpAnswerList.length) {
                                        if (FFAppState()
                                            .tmpAnswerList
                                            .elementAtOrNull(
                                                _model.tmpAnswerIndex!)!
                                            .answer
                                            .isNotEmpty) {
                                          _model.updatePassListAtIndex(
                                            _model.tmpAnswerIndex!,
                                            (_) => true,
                                          );
                                        } else {
                                          _model.updatePassListAtIndex(
                                            _model.tmpAnswerIndex!,
                                            (_) => false,
                                          );
                                        }

                                        _model.tmpAnswerIndex =
                                            _model.tmpAnswerIndex! + 1;
                                      }
                                      if (_model.passList.contains(false)) {
                                        safeSetState(() {});
                                      } else {
                                        await AnswerListRecord.createDoc(widget!
                                                .pollDocument!.parentReference)
                                            .set({
                                          ...createAnswerListRecordData(
                                            createDate: getCurrentTimestamp,
                                            pollRef:
                                                widget!.pollDocument?.reference,
                                            createBy: loggedIn
                                                ? currentUserReference
                                                : null,
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

                                        await widget!.pollDocument!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'total_answer':
                                                  FieldValue.increment(1),
                                            },
                                          ),
                                        });
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: WebViewAware(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: InfoCustomViewWidget(
                                                    title:
                                                        'ส่งข้อมูลเรียบร้อยแล้ว',
                                                    status: 'success',
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );

                                        context.safePop();
                                      }
                                    },
                                    text: 'ส่งข้อมูล',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 57.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
      ),
    );
  }
}
