import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/poll_view/poll_component/q_r_code_poll_view/q_r_code_poll_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'more_poll_view_widget.dart' show MorePollViewWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class MorePollViewModel extends FlutterFlowModel<MorePollViewWidget> {
  ///  Local state fields for this component.

  List<String> optionList = [];
  void addToOptionList(String item) => optionList.add(item);
  void removeFromOptionList(String item) => optionList.remove(item);
  void removeAtIndexFromOptionList(int index) => optionList.removeAt(index);
  void insertAtIndexInOptionList(int index, String item) =>
      optionList.insert(index, item);
  void updateOptionListAtIndex(int index, Function(String) updateFn) =>
      optionList[index] = updateFn(optionList[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - exportPDF] action in Column widget.
  String? path2;
  // Stores action output result for [Custom Action - exportExcel] action in Column widget.
  String? path;
  // Stores action output result for [Action Block - confirmBlock] action in Column widget.
  bool? isConfirm;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
