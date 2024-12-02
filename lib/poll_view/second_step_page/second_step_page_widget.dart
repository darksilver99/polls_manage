import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/poll_view/question_pre_view/question_pre_view_widget.dart';
import '/poll_view/select_type_view/select_type_view_widget.dart';
import '/poll_view/step_view/step_view_widget.dart';
import '/poll_view/topic_form_view/topic_form_view_widget.dart';
import '/poll_view/type_form_view/type_form_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'บันทึกแบบร่าง',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).warning,
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
                    FFButtonWidget(
                      onPressed: () async {
                        _model.isConfirm = await action_blocks.confirmBlock(
                          context,
                          title: 'ต้องการยกเลิก?',
                        );
                        if (_model.isConfirm!) {
                          await actions.pushReplacement(
                            context,
                            null,
                          );
                        }

                        safeSetState(() {});
                      },
                      text: 'ยกเลิก',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).error,
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
              Divider(
                height: 32.0,
                thickness: 2.0,
                indent: 16.0,
                endIndent: 16.0,
                color: FlutterFlowTheme.of(context).alternate,
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

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(questionList.length,
                          (questionListIndex) {
                        final questionListItem =
                            questionList[questionListIndex];
                        return InkWell(
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
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: QuestionPreViewWidget(
                                      questionData: questionListItem,
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
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
                        );
                      }).divide(SizedBox(height: 8.0)),
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
                      child: FFButtonWidget(
                        onPressed: () async {
                          await actions.hideKeyBoard(
                            context,
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
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
