import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  final Map data;
  const Graph({Key? key, required this.data}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CasesDataType> cases = [];
    List<CasesDataType> recovered = [];
    List<CasesDataType> deaths = [];

    for (int i = 0; i < widget.data['timeline']['cases'].length; i++) {
      if (i != 0) {
        if (widget.data['timeline']['cases'].values.elementAt(i) == 0 ||
            widget.data['timeline']['cases'].values.elementAt(i) <
                widget.data['timeline']['cases'].values.elementAt(i - 1)) {
          recovered.add(CasesDataType(
              widget.data['timeline']['cases'].keys.elementAt(i), 0));
        } else {
          cases.add(CasesDataType(
              widget.data['timeline']['cases'].keys.elementAt(i),
              widget.data['timeline']['cases'].values.elementAt(i).toDouble() -
                  widget.data['timeline']['cases'].values
                      .elementAt(i - 1)
                      .toDouble()));
        }
        if (widget.data['timeline']['recovered'].values.elementAt(i) == 0 ||
            widget.data['timeline']['recovered'].values.elementAt(i) <
                widget.data['timeline']['recovered'].values.elementAt(i - 1)) {
          recovered.add(CasesDataType(
              widget.data['timeline']['recovered'].keys.elementAt(i), 0));
        } else {
          recovered.add(CasesDataType(
              widget.data['timeline']['recovered'].keys.elementAt(i),
              widget.data['timeline']['recovered'].values
                      .elementAt(i)
                      .toDouble() -
                  widget.data['timeline']['recovered'].values
                      .elementAt(i - 1)
                      .toDouble()));
        }
        if (widget.data['timeline']['deaths'].values.elementAt(i) == 0 ||
            widget.data['timeline']['deaths'].values.elementAt(i) <
                widget.data['timeline']['deaths'].values.elementAt(i - 1)) {
          recovered.add(CasesDataType(
              widget.data['timeline']['deaths'].keys.elementAt(i), 0));
        } else {
          deaths.add(CasesDataType(
              widget.data['timeline']['deaths'].keys.elementAt(i),
              widget.data['timeline']['deaths'].values.elementAt(i).toDouble() -
                  widget.data['timeline']['deaths'].values
                      .elementAt(i - 1)
                      .toDouble()));
        }
      } else {
        cases.add(CasesDataType(
            widget.data['timeline']['cases'].keys.elementAt(i),
            widget.data['timeline']['cases'].values.elementAt(i).toDouble()));
        recovered.add(CasesDataType(
            widget.data['timeline']['recovered'].keys.elementAt(i),
            widget.data['timeline']['recovered'].values
                .elementAt(i)
                .toDouble()));
        deaths.add(CasesDataType(
            widget.data['timeline']['deaths'].keys.elementAt(i),
            widget.data['timeline']['deaths'].values.elementAt(i).toDouble()));
      }
    }
    return Container(
      child: SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: "${widget.data['country']}'s Trends of Cases"),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        series: <ChartSeries>[
          LineSeries<CasesDataType, String>(
            name: "Cases",
            color: Colors.red,
            enableTooltip: true,
            dataSource: cases,
            xValueMapper: (CasesDataType cases, _) => cases.date,
            yValueMapper: (CasesDataType cases, _) => cases.number,
          ),
          LineSeries<CasesDataType, String>(
            name: "Recovered",
            color: Colors.green,
            enableTooltip: true,
            dataSource: recovered,
            xValueMapper: (CasesDataType cases, _) => cases.date,
            yValueMapper: (CasesDataType cases, _) => cases.number,
          ),
          LineSeries<CasesDataType, String>(
            name: "Deaths",
            color: Colors.grey[800],
            enableTooltip: true,
            dataSource: deaths,
            xValueMapper: (CasesDataType cases, _) => cases.date,
            yValueMapper: (CasesDataType cases, _) => cases.number,
          )
        ],
      ),
    );
  }
}

class CasesDataType {
  final String date;
  final double number;

  CasesDataType(this.date, this.number);
}
