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
import 'poll_detail_page_widget.dart' show PollDetailPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PollDetailPageModel extends FlutterFlowModel<PollDetailPageWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  int? tmpAnswerIndex = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in PollDetailPage widget.
  PollListRecord? pollResult;
  // Models for TextFieldAnswerView dynamic component.
  late FlutterFlowDynamicModels<TextFieldAnswerViewModel>
      textFieldAnswerViewModels;

  @override
  void initState(BuildContext context) {
    textFieldAnswerViewModels =
        FlutterFlowDynamicModels(() => TextFieldAnswerViewModel());
  }

  @override
  void dispose() {
    textFieldAnswerViewModels.dispose();
  }
}
