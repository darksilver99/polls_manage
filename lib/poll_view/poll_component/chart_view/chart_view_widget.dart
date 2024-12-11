import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chart_view_model.dart';
export 'chart_view_model.dart';

class ChartViewWidget extends StatefulWidget {
  const ChartViewWidget({
    super.key,
    required this.summaryData,
  });

  final SummaryDataStruct? summaryData;

  @override
  State<ChartViewWidget> createState() => _ChartViewWidgetState();
}

class _ChartViewWidgetState extends State<ChartViewWidget> {
  late ChartViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChartViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chartPieChartColorsList = [
      Color(0xFF8F46E9),
      Color(0xFF6F28CB),
      Color(0xFF2536A4),
      Color(0xFF4A57C1)
    ];
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
          child: Container(
            width: 370.0,
            height: 230.0,
            child: FlutterFlowPieChart(
              data: FFPieChartData(
                values:
                    widget!.summaryData!.answers.map((e) => e.total).toList(),
                colors: chartPieChartColorsList,
                radius: [100.0],
              ),
              donutHoleRadius: 0.0,
              donutHoleColor: Colors.transparent,
              sectionLabelType: PieChartSectionLabelType.value,
              sectionLabelStyle:
                  FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Kanit',
                        letterSpacing: 0.0,
                      ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                valueOrDefault<String>(
                  widget!.summaryData?.question,
                  '-',
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Kanit',
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
