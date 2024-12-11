import '/backend/schema/structs/index.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/poll_component/draft_view/draft_view_widget.dart';
import '/poll_view/poll_component/question_pre_view/question_pre_view_widget.dart';
import '/poll_view/poll_component/select_type_view/select_type_view_widget.dart';
import '/poll_view/poll_component/step_view/step_view_widget.dart';
import '/poll_view/poll_component/topic_form_view/topic_form_view_widget.dart';
import '/poll_view/poll_component/type_form_view/type_form_view_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'second_step_page_model.dart';
export 'second_step_page_model.dart';

class SecondStepPageWidget extends StatefulWidget {
  const SecondStepPageWidget({super.key});

  @override
  State<SecondStepPageWidget> createState() => _SecondStepPageWidgetState();
}

class _SecondStepPageWidgetState extends State<SecondStepPageWidget> {
  late SecondStepPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SecondStepPageModel());
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
                  currentStep: 2,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
                child: Builder(
                  builder: (context) {
                    final questionList =
                        FFAppState().tmpQuestionDataList.toList();

                    return ReorderableListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: questionList.length,
                      itemBuilder: (context, questionListIndex) {
                        final questionListItem =
                            questionList[questionListIndex];
                        return Container(
                          key: ValueKey("ListView_6ipfxobv" +
                              '_' +
                              questionListIndex.toString()),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 8.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: QuestionPreViewWidget(
                                          questionData: questionListItem,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) =>
                                    safeSetState(() => _model.isEdit = value));

                                if ((_model.isEdit != null &&
                                        _model.isEdit != '') &&
                                    (_model.isEdit == 'edit')) {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return WebViewAware(
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: TopicFormViewWidget(
                                            topic: questionListItem.topic,
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(
                                      () => _model.topicEdit = value));

                                  if (_model.topicEdit != null &&
                                      _model.topicEdit != '') {
                                    if (questionListItem.type != 1) {
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
                                              child: TypeFormViewWidget(
                                                optionList:
                                                    questionListItem.optionList,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(
                                          () => _model.optionEditList = value));

                                      if (_model.optionEditList != null &&
                                          (_model.optionEditList)!.isNotEmpty) {
                                        FFAppState()
                                            .updateTmpQuestionDataListAtIndex(
                                          questionListIndex,
                                          (e) => e
                                            ..topic = _model.topicEdit
                                            ..optionList =
                                                _model.optionEditList!.toList(),
                                        );
                                        FFAppState().update(() {});
                                      }
                                    } else {
                                      FFAppState()
                                          .updateTmpQuestionDataListAtIndex(
                                        questionListIndex,
                                        (e) => e..topic = _model.topicEdit,
                                      );
                                      FFAppState().update(() {});
                                    }
                                  }
                                }

                                safeSetState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 8.0, 16.0, 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 8.0, 0.0),
                                        child: Icon(
                                          Icons.reorder_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          questionListItem.topic,
                                          maxLines: 2,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Kanit',
                                                fontSize: 24.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.navigate_next_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 32.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      onReorder: (int reorderableOldIndex,
                          int reorderableNewIndex) async {
                        FFAppState().tmpQuestionDataList = functions
                            .reorderItems(
                                FFAppState().tmpQuestionDataList.toList(),
                                reorderableOldIndex,
                                reorderableNewIndex)
                            .toList()
                            .cast<QuestionDataStruct>();
                        FFAppState().update(() {});

                        safeSetState(() {});
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          useSafeArea: true,
                          context: context,
                          builder: (context) {
                            return WebViewAware(
                              child: Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: SelectTypeViewWidget(),
                              ),
                            );
                          },
                        ).then((value) =>
                            safeSetState(() => _model.typeID = value));

                        if (_model.typeID != null) {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return WebViewAware(
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: TopicFormViewWidget(),
                                ),
                              );
                            },
                          ).then((value) =>
                              safeSetState(() => _model.topic = value));

                          if (_model.topic != null && _model.topic != '') {
                            if (_model.typeID == 1) {
                              FFAppState()
                                  .addToTmpQuestionDataList(QuestionDataStruct(
                                topic: _model.topic,
                                type: _model.typeID,
                                topicId: random_data.randomString(
                                  5,
                                  5,
                                  true,
                                  true,
                                  true,
                                ),
                              ));
                              safeSetState(() {});
                            } else {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                useSafeArea: true,
                                context: context,
                                builder: (context) {
                                  return WebViewAware(
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: TypeFormViewWidget(),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(
                                  () => _model.optionList = value));

                              if (_model.optionList != null &&
                                  (_model.optionList)!.isNotEmpty) {
                                FFAppState().addToTmpQuestionDataList(
                                    QuestionDataStruct(
                                  topic: _model.topic,
                                  type: _model.typeID,
                                  optionList: _model.optionList,
                                  topicId: random_data.randomString(
                                    5,
                                    5,
                                    true,
                                    true,
                                    true,
                                  ),
                                ));
                                safeSetState(() {});
                              }
                            }
                          }
                        }

                        safeSetState(() {});
                      },
                      text: 'เพิ่มข้อ',
                      icon: Icon(
                        Icons.add_sharp,
                        size: 18.0,
                      ),
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).success,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Kanit',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
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
                          color: FlutterFlowTheme.of(context).secondaryText,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                            if (FFAppState().tmpQuestionDataList.isNotEmpty) {
                              FFAppState().updateTmpPollDataStruct(
                                (e) => e
                                  ..questionList =
                                      FFAppState().tmpQuestionDataList.toList(),
                              );

                              context.pushNamed(
                                'LastStepPage',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );
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
                                      child: InfoCustomViewWidget(
                                        title: 'กรุณาเพิ่มคำถาม',
                                        status: 'error',
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          text: 'ถัดไป',
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
            ]
                .addToStart(SizedBox(height: 8.0))
                .addToEnd(SizedBox(height: 180.0)),
          ),
        ),
      ),
    );
  }
}
