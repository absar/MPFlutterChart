import 'dart:math';

import 'package:mp_flutter_chart/chart/mp/core/common_interfaces.dart';
import 'package:flutter/material.dart';
import 'package:mp_flutter_chart/chart/mp/chart/bar_chart.dart';
import 'package:mp_flutter_chart/chart/mp/core/data/bar_data.dart';
import 'package:mp_flutter_chart/chart/mp/core/data_interfaces/i_bar_data_set.dart';
import 'package:mp_flutter_chart/chart/mp/core/data_set/bar_data_set.dart';
import 'package:mp_flutter_chart/chart/mp/core/description.dart';
import 'package:mp_flutter_chart/chart/mp/core/entry/bar_entry.dart';
import 'package:mp_flutter_chart/chart/mp/core/entry/entry.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_form.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_horizontal_alignment.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_orientation.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_vertical_alignment.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/x_axis_position.dart';
import 'package:mp_flutter_chart/chart/mp/core/highlight/highlight.dart';
import 'package:mp_flutter_chart/chart/mp/core/utils/color_utils.dart';
import 'package:mp_flutter_chart/chart/mp/core/value_formatter/my_value_formatter.dart';
import 'package:mp_flutter_chart/chart/mp/core/value_formatter/stacked_value_formatter.dart';
import 'package:mp_flutter_chart/chart/mp/core/value_formatter/value_formatter.dart';

class BarChartStacked extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BarChartStackedState();
  }
}

class BarChartStackedState extends State<BarChartStacked>
    implements OnChartValueSelectedListener {
  BarChart _barChart;
  BarData _barData;

  var random = Random(1);

  int _count = 12;
  double _range = 100.0;

  @override
  void initState() {
    _initBarData(_count, _range);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initBarChart();
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Bar Chart Stacked")),
        body: Stack(
          children: <Widget>[
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 100,
              child: _barChart,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                            child: Slider(
                                value: _count.toDouble(),
                                min: 0,
                                max: 1500,
                                onChanged: (value) {
                                  _count = value.toInt();
                                  _initBarData(_count, _range);
                                  setState(() {});
                                })),
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Text(
                            "$_count",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorUtils.BLACK,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                            child: Slider(
                                value: _range,
                                min: 0,
                                max: 200,
                                onChanged: (value) {
                                  _range = value;
                                  _initBarData(_count, _range);
                                  setState(() {});
                                })),
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Text(
                            "${_range.toInt()}",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorUtils.BLACK,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _initBarData(int count, double range) {
    List<BarEntry> values = List();

    for (int i = 0; i < count; i++) {
      double mul = (range + 1);
      double val1 = (random.nextDouble() * mul) + mul / 3;
      double val2 = (random.nextDouble() * mul) + mul / 3;
      double val3 = (random.nextDouble() * mul) + mul / 3;

      values.add(BarEntry.fromListYVals(
          x: i.toDouble(), vals: List()..add(val1)..add(val2)..add(val3)));
    }

    BarDataSet set1;

    set1 = BarDataSet(values, "Statistics Vienna 2014");
    set1.setDrawIcons(false);
    set1.setColors1(_getColors());
    set1.setStackLabels(
        List()..add("Births")..add("Divorces")..add("Marriages"));

    List<IBarDataSet> dataSets = List();
    dataSets.add(set1);

    _barData = BarData(dataSets);
    _barData.setValueFormatter(StackedValueFormatter(false, "", 1));
    _barData.setValueTextColor(ColorUtils.WHITE);
  }

  List<Color> _getColors() {
    return List()
      ..add(ColorUtils.MATERIAL_COLORS[0])
      ..add(ColorUtils.MATERIAL_COLORS[1])
      ..add(ColorUtils.MATERIAL_COLORS[2]);
  }

  void _initBarChart() {
    var desc = Description();
    desc.setEnabled(false);
    _barChart = BarChart(_barData, (painter) {
      painter
        ..mMarker = null
        ..setFitBars(true)
        ..setOnChartValueSelectedListener(this)
        ..mMaxVisibleCount = 60
        ..setDrawBarShadow(false)
        ..setHighlightFullBarEnabled(false)
        ..setDrawValueAboveBar(false);

      painter.mXAxis.setPosition(XAxisPosition.TOP);

      ValueFormatter custom = MyValueFormatter("K");
      painter.mAxisLeft
        ..setValueFormatter(custom)
        ..setAxisMinimum(0);

      painter.mAxisRight.setEnabled(false);

      painter.mLegend
        ..setVerticalAlignment(LegendVerticalAlignment.BOTTOM)
        ..setHorizontalAlignment(LegendHorizontalAlignment.RIGHT)
        ..setOrientation(LegendOrientation.HORIZONTAL)
        ..setDrawInside(false)
        ..setForm(LegendForm.SQUARE)
        ..setFormSize(8)
        ..setFormToTextSpace(4)
        ..setXEntrySpace(6);
    },
        touchEnabled: true,
        drawGridBackground: false,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: false,
        maxVisibleCount: 60,
        desc: desc);
  }

  @override
  void onNothingSelected() {}

  @override
  void onValueSelected(Entry e, Highlight h) {}
}
