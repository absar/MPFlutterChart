import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mp_flutter_chart/chart/mp/chart/chart.dart';
import 'package:mp_flutter_chart/chart/mp/core/common_interfaces.dart';
import 'package:mp_flutter_chart/chart/mp/core/data/line_data.dart';
import 'package:mp_flutter_chart/chart/mp/core/description.dart';
import 'package:mp_flutter_chart/chart/mp/core/highlight/i_highlighter.dart';
import 'package:mp_flutter_chart/chart/mp/core/marker/i_marker.dart';
import 'package:mp_flutter_chart/chart/mp/core/marker/line_chart_marker.dart';
import 'package:mp_flutter_chart/chart/mp/core/render/x_axis_renderer.dart';
import 'package:mp_flutter_chart/chart/mp/core/render/y_axis_renderer.dart';
import 'package:mp_flutter_chart/chart/mp/painter/line_chart_painter.dart';

class LineChart extends Chart {
  Color backgroundColor = null;
  Color borderColor = null;
  double borderStrokeWidth = 1.0;
  bool keepPositionOnRotation = false;
  bool pinchZoomEnabled = false;
  XAxisRenderer xAxisRenderer = null;
  YAxisRenderer rendererLeftYAxis = null;
  YAxisRenderer rendererRightYAxis = null;
  bool autoScaleMinMaxEnabled = false;
  bool clipValuesToContent = false;
  bool drawBorders = false;
  bool drawGridBackground = false;
  bool doubleTapToZoomEnabled = true;
  bool scaleXEnabled = true;
  bool scaleYEnabled = true;
  bool dragXEnabled = true;
  bool dragYEnabled = true;
  bool highlightPerDragEnabled = true;
  int maxVisibleCount = 100;
  OnDrawListener drawListener = null;
  double minXRange = 1.0;
  double maxXRange = 1.0;
  double minimumScaleX = 1.0;
  double minimumScaleY = 1.0;

  LineChart(
      LineData data, InitLineChartPainterCallback initLineChartPainterCallback,
      {Color backgroundColor = null,
      Color borderColor = null,
      double borderStrokeWidth = 1.0,
      bool keepPositionOnRotation = false,
      bool pinchZoomEnabled = false,
      XAxisRenderer xAxisRenderer = null,
      YAxisRenderer rendererLeftYAxis = null,
      YAxisRenderer rendererRightYAxis = null,
      bool autoScaleMinMaxEnabled = false,
      double minOffset = 30,
      bool clipValuesToContent = false,
      bool drawBorders = false,
      bool drawGridBackground = false,
      bool doubleTapToZoomEnabled = true,
      bool scaleXEnabled = true,
      bool scaleYEnabled = true,
      bool dragXEnabled = true,
      bool dragYEnabled = true,
      bool highlightPerDragEnabled = true,
      int maxVisibleCount = 100,
      OnDrawListener drawListener = null,
      double minXRange = 1.0,
      double maxXRange = 1.0,
      double minimumScaleX = 1.0,
      double minimumScaleY = 1.0,
      double maxHighlightDistance = 0.0,
      bool highLightPerTapEnabled = true,
      bool dragDecelerationEnabled = true,
      double dragDecelerationFrictionCoef = 0.9,
      double extraLeftOffset = 0.0,
      double extraTopOffset = 0.0,
      double extraRightOffset = 0.0,
      double extraBottomOffset = 0.0,
      String noDataText = "No chart data available.",
      bool touchEnabled = true,
      IMarker marker = null,
      Description desc = null,
      bool drawMarkers = true,
      TextPainter infoPainter = null,
      TextPainter descPainter = null,
      IHighlighter highlighter = null,
      bool unbind = false})
      : backgroundColor = backgroundColor,
        borderColor = borderColor,
        borderStrokeWidth = borderStrokeWidth,
        keepPositionOnRotation = keepPositionOnRotation,
        pinchZoomEnabled = pinchZoomEnabled,
        xAxisRenderer = xAxisRenderer,
        rendererLeftYAxis = rendererLeftYAxis,
        rendererRightYAxis = rendererRightYAxis,
        autoScaleMinMaxEnabled = autoScaleMinMaxEnabled,
        clipValuesToContent = clipValuesToContent,
        drawBorders = drawBorders,
        drawGridBackground = drawGridBackground,
        doubleTapToZoomEnabled = doubleTapToZoomEnabled,
        scaleXEnabled = scaleXEnabled,
        scaleYEnabled = scaleYEnabled,
        dragXEnabled = dragXEnabled,
        dragYEnabled = dragYEnabled,
        highlightPerDragEnabled = highlightPerDragEnabled,
        maxVisibleCount = maxVisibleCount,
        drawListener = drawListener,
        minXRange = minXRange,
        maxXRange = maxXRange,
        minimumScaleX = minimumScaleX,
        minimumScaleY = minimumScaleY,
        super(
          data,
          (painter) {
            if (painter is LineChartPainter) {
              initLineChartPainterCallback(painter);
            }
          },
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          borderStrokeWidth: borderStrokeWidth,
          keepPositionOnRotation: keepPositionOnRotation,
          pinchZoomEnabled: pinchZoomEnabled,
          xAxisRenderer: xAxisRenderer,
          rendererLeftYAxis: rendererLeftYAxis,
          rendererRightYAxis: rendererRightYAxis,
          autoScaleMinMaxEnabled: autoScaleMinMaxEnabled,
          clipValuesToContent: clipValuesToContent,
          drawBorders: drawBorders,
          drawGridBackground: drawGridBackground,
          doubleTapToZoomEnabled: doubleTapToZoomEnabled,
          scaleXEnabled: scaleXEnabled,
          scaleYEnabled: scaleYEnabled,
          dragXEnabled: dragXEnabled,
          dragYEnabled: dragYEnabled,
          highlightPerDragEnabled: highlightPerDragEnabled,
          maxVisibleCount: maxVisibleCount,
          drawListener: drawListener,
          minXRange: minXRange,
          maxXRange: maxXRange,
          minimumScaleX: minimumScaleX,
          minimumScaleY: minimumScaleY,
          maxHighlightDistance: maxHighlightDistance,
          highLightPerTapEnabled: highLightPerTapEnabled,
          dragDecelerationEnabled: dragDecelerationEnabled,
          dragDecelerationFrictionCoef: dragDecelerationFrictionCoef,
          extraLeftOffset: extraLeftOffset,
          extraTopOffset: extraTopOffset,
          extraRightOffset: extraRightOffset,
          extraBottomOffset: extraBottomOffset,
          touchEnabled: touchEnabled,
          noDataText: noDataText,
          marker: marker,
          desc: desc,
          drawMarkers: drawMarkers,
          infoPainter: infoPainter,
          descPainter: descPainter,
          highlighter: highlighter,
          unbind: unbind,
        ) {
    this.marker = LineChartMarker();
  }

  @override
  State<StatefulWidget> createState() {
    return LineChartState();
  }
}

class LineChartState extends BarLineScatterCandleBubbleState<LineChartPainter, LineChart> {
  @override
  void initialPainter() {
    painter = LineChartPainter(widget.data,
        viewPortHandler: widget.viewPortHandler,
        animator: animator,
        backgroundColor: widget.backgroundColor,
        borderColor: widget.borderColor,
        borderStrokeWidth: widget.borderStrokeWidth,
        keepPositionOnRotation: widget.keepPositionOnRotation,
        pinchZoomEnabled: widget.pinchZoomEnabled,
        xAxisRenderer: widget.xAxisRenderer,
        rendererLeftYAxis: widget.rendererLeftYAxis,
        rendererRightYAxis: widget.rendererRightYAxis,
        autoScaleMinMaxEnabled: widget.autoScaleMinMaxEnabled,
        minOffset: widget.minOffset,
        clipValuesToContent: widget.clipValuesToContent,
        drawBorders: widget.drawBorders,
        drawGridBackground: widget.drawGridBackground,
        doubleTapToZoomEnabled: widget.doubleTapToZoomEnabled,
        scaleXEnabled: widget.scaleXEnabled,
        scaleYEnabled: widget.scaleYEnabled,
        dragXEnabled: widget.dragXEnabled,
        dragYEnabled: widget.dragYEnabled,
        highlightPerDragEnabled: widget.highlightPerDragEnabled,
        maxVisibleCount: widget.maxVisibleCount,
        drawListener: widget.drawListener,
        minXRange: widget.minXRange,
        maxXRange: widget.maxXRange,
        minimumScaleX: widget.minimumScaleX,
        minimumScaleY: widget.minimumScaleY,
        maxHighlightDistance: widget.maxHighlightDistance,
        highLightPerTapEnabled: widget.highLightPerTapEnabled,
        dragDecelerationEnabled: widget.dragDecelerationEnabled,
        dragDecelerationFrictionCoef: widget.dragDecelerationFrictionCoef,
        extraLeftOffset: widget.extraLeftOffset,
        extraTopOffset: widget.extraTopOffset,
        extraRightOffset: widget.extraRightOffset,
        extraBottomOffset: widget.extraBottomOffset,
        noDataText: widget.noDataText,
        touchEnabled: widget.touchEnabled,
        marker: widget.marker,
        desc: widget.desc,
        drawMarkers: widget.drawMarkers,
        infoPainter: widget.infoPainter,
        descPainter: widget.descPainter,
        highlighter: widget.highlighter,
        unbind: widget.unbind);
    painter.highlightValue6(lastHighlighted, false);
  }
}

typedef InitLineChartPainterCallback = void Function(LineChartPainter painter);
