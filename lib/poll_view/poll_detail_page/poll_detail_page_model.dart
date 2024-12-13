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
import 'poll_detail_page_widget.dart' show PollDetailPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PollDetailPageModel extends FlutterFlowModel<PollDetailPageWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  int? tmpAnswerIndex = 0;

  List<bool> passList = [];
  void addToPassList(bool item) => passList.add(item);
  void removeFromPassList(bool item) => passList.remove(item);
  void removeAtIndexFromPassList(int index) => passList.removeAt(index);
  void insertAtIndexInPassList(int index, bool item) =>
      passList.insert(index, item);
  void updatePassListAtIndex(int index, Function(bool) updateFn) =>
      passList[index] = updateFn(passList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in PollDetailPage widget.
  PollListRecord? pollResult;
  // Stores action output result for [Action Block - confirmBlock] action in Icon widget.
  bool? isConfirm;
  // Models for TextFieldAnswerView dynamic component.
  late FlutterFlowDynamicModels<TextFieldAnswerViewModel>
      textFieldAnswerViewModels;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  PollListRecord? pollDocument;

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
