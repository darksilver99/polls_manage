import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'back_button_view_model.dart';
export 'back_button_view_model.dart';

class BackButtonViewWidget extends StatefulWidget {
  const BackButtonViewWidget({super.key});

  @override
  State<BackButtonViewWidget> createState() => _BackButtonViewWidgetState();
}

class _BackButtonViewWidgetState extends State<BackButtonViewWidget> {
  late BackButtonViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BackButtonViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: Material(
              color: Colors.transparent,
              elevation: 3.0,
              shape: const CircleBorder(),
              child: Container(
                width: 52.0,
                height: 52.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 36.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            'แบบสำรวจของฉัน',
            maxLines: 1,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Kanit',
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ],
    );
  }
}
