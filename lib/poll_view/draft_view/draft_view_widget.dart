import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'draft_view_model.dart';
export 'draft_view_model.dart';

class DraftViewWidget extends StatefulWidget {
  const DraftViewWidget({super.key});

  @override
  State<DraftViewWidget> createState() => _DraftViewWidgetState();
}

class _DraftViewWidgetState extends State<DraftViewWidget> {
  late DraftViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DraftViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                },
                text: 'บันทึกแบบร่าง',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).warning,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Kanit',
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w300,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
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
                child: Text(
                  'ยกเลิก',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Kanit',
                        color: FlutterFlowTheme.of(context).error,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                      ),
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
      ],
    );
  }
}
