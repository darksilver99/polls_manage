import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'step_view_model.dart';
export 'step_view_model.dart';

class StepViewWidget extends StatefulWidget {
  const StepViewWidget({
    super.key,
    required this.currentStep,
  });

  final int? currentStep;

  @override
  State<StepViewWidget> createState() => _StepViewWidgetState();
}

class _StepViewWidgetState extends State<StepViewWidget> {
  late StepViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StepViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiary,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      '1',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Kanit',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 26.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowRight,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 32.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: widget!.currentStep! >= 2
                        ? FlutterFlowTheme.of(context).tertiary
                        : FlutterFlowTheme.of(context).alternate,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      '2',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Kanit',
                            color: widget!.currentStep! >= 2
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 26.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowRight,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 32.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: widget!.currentStep! >= 3
                        ? FlutterFlowTheme.of(context).tertiary
                        : FlutterFlowTheme.of(context).alternate,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      '3',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Kanit',
                            color: widget!.currentStep! >= 3
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 26.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  () {
                    if (widget!.currentStep == 1) {
                      return 'กรุณาตั้งชื่อแบบสอบถามของคุณ พร้อมเพิ่มรายละเอียดสั้น ๆ เพื่ออธิบายเนื้อหาหรือเป้าหมายของแบบสอบถามนี้';
                    } else if (widget!.currentStep == 2) {
                      return 'เพิ่มคำถามในแบบสอบถามของคุณ คุณสามารถเลือกประเภทคำตอบได้ เช่น คำตอบแบบพิมพ์, เลือกข้อเดียว หรือเลือกหลายข้อ';
                    } else {
                      return 'ตั้งวันที่เริ่มต้นและสิ้นสุดของแบบสอบถาม เพื่อกำหนดช่วงเวลาที่ผู้ตอบสามารถเข้ามาให้คำตอบได้';
                    }
                  }(),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Kanit',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
