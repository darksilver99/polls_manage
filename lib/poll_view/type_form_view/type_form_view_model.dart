import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'type_form_view_widget.dart' show TypeFormViewWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class TypeFormViewModel extends FlutterFlowModel<TypeFormViewWidget> {
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

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
