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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  valueOrDefault<String>(
                    widget!.summaryData?.question,
                    '-',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Kanit',
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
          child: Container(
            width: double.infinity,
            height: 230.0,
            child: FlutterFlowBarChart(
              barData: [
                FFBarChartData(
                  yData:
                      widget!.summaryData!.answers.map((e) => e.total).toList(),
                  color: FlutterFlowTheme.of(context).primary,
                )
              ],
              xLabels:
                  widget!.summaryData!.answers.map((e) => e.answer).toList(),
              barWidth: 16.0,
              barBorderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
              groupSpace: 8.0,
              alignment: BarChartAlignment.spaceEvenly,
              chartStylingInfo: ChartStylingInfo(
                enableTooltip: true,
                tooltipBackgroundColor: Colors.transparent,
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                showGrid: true,
                borderColor: FlutterFlowTheme.of(context).secondaryText,
                borderWidth: 1.0,
              ),
              axisBounds: AxisBounds(),
              xAxisLabelInfo: AxisLabelInfo(
                showLabels: true,
                labelTextStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 12.0,
                ),
                labelInterval: 10.0,
                reservedSize: 28.0,
              ),
              yAxisLabelInfo: AxisLabelInfo(
                reservedSize: 24.0,
              ),
            ),
          ),
        ),
        Divider(
          thickness: 2.0,
          indent: 16.0,
          endIndent: 16.0,
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ],
    );
  }
}
